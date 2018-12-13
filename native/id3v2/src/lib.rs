#[macro_use]
extern crate rustler;
#[macro_use]
extern crate rustler_codegen;
#[macro_use]
extern crate lazy_static;
extern crate id3;

mod datetime;

use datetime::NaiveDateTime;
use id3::{Tag, Version};
use rustler::{Encoder, Env, NifResult, Term};

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
        atom file_open_error;
        atom tag_write_error;
    }
}

rustler_export_nifs! {
    "Elixir.ID3V2.Native",
    [
        ("get_major_frames", 1, major_frames),
        ("write_major_frames", 2, write_major_frames),
    ],
    None
}

#[derive(NifStruct)]
#[module = "ID3V2.Tag"]
/// Struct for passing major tag data to/from Elixir.
struct MajorFrames<'a> {
    // pub comments: Option<String>,
    pub year: Option<i32>,
    pub date_recorded: Option<NaiveDateTime>,
    pub date_released: Option<NaiveDateTime>,
    pub artist: Option<&'a str>,
    pub album_artist: Option<&'a str>,
    pub title: Option<&'a str>,
    pub duration: Option<u32>,
    pub genre: Option<&'a str>,
    pub disc: Option<u32>,
    pub total_discs: Option<u32>,
    pub track: Option<u32>,
    pub total_tracks: Option<u32>,
}

fn major_frames<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let path: String = try!(args[0].decode());

    match Tag::read_from_path(path) {
        Ok(tag) => {
            let frames = MajorFrames {
                // comments:
                year: tag.year(),
                date_recorded: tag.date_recorded().map(NaiveDateTime::from),
                date_released: tag.date_released().map(NaiveDateTime::from),
                artist: tag.artist(),
                album_artist: tag.album_artist(),
                title: tag.title(),
                duration: tag.duration(),
                genre: tag.genre(),
                disc: tag.disc(),
                total_discs: tag.total_discs(),
                track: tag.track(),
                total_tracks: tag.total_tracks(),
            };
            Ok((atoms::ok(), frames).encode(env))
        }
        Err(_e) => Ok((atoms::error(), atoms::file_open_error()).encode(env)),
    }
}

fn write_major_frames<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let path: String = args[0].decode()?;
    let frames: MajorFrames = args[1].decode()?;

    match Tag::read_from_path(&path) {
        Ok(tag) => {
            let mut tag = tag;
            match frames.year {
                Some(year) => tag.set_year(year),
                None => tag.remove("TYER"),
            };
            match frames.date_recorded {
                Some(date) => tag.set_date_recorded(date.into()),
                None => tag.remove("TDRC"),
            };
            match frames.date_released {
                Some(date) => tag.set_date_released(date.into()),
                None => tag.remove("TDRL"),
            };
            match frames.artist {
                Some(artist) => tag.set_artist(artist),
                None => tag.remove_artist(),
            };
            match frames.album_artist {
                Some(artist) => tag.set_album_artist(artist),
                None => tag.remove_album_artist(),
            };
            match frames.title {
                Some(artist) => tag.set_title(artist),
                None => tag.remove_title(),
            };
            match frames.duration {
                Some(artist) => tag.set_duration(artist),
                None => tag.remove_duration(),
            };
            match frames.genre {
                Some(artist) => tag.set_genre(artist),
                None => tag.remove_genre(),
            };
            match frames.disc {
                Some(artist) => tag.set_disc(artist),
                None => tag.remove_disc(),
            };
            match frames.total_discs {
                Some(artist) => tag.set_total_discs(artist),
                None => tag.remove_total_discs(),
            };
            match frames.track {
                Some(artist) => tag.set_track(artist),
                None => tag.remove_track(),
            };
            match frames.total_tracks {
                Some(artist) => tag.set_total_tracks(artist),
                None => tag.remove_total_tracks(),
            };

            match tag.write_to_path(&path, Version::Id3v24) {
                Ok(_) => Ok(atoms::ok().encode(env)),
                Err(_) => Ok((atoms::error(), atoms::tag_write_error()).encode(env)),
            }
        }
        Err(_e) => Ok((atoms::error(), atoms::file_open_error()).encode(env)),
    }
}

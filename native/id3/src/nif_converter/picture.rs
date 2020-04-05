use crate::NifBinary;
use id3::frame::{Picture, PictureType};
use rustler::types::atom::Atom as NifAtom;
use rustler::NifStruct;

mod atoms {
    use rustler::rustler_atoms;

    rustler_atoms! {
        atom ok;
        atom error;
    }
}

#[allow(non_snake_case)]
mod pictype_atoms {
    use rustler::rustler_atoms;

    rustler_atoms! {
        atom Other;
        atom Icon;
        atom OtherIcon;
        atom CoverFront;
        atom CoverBack;
        atom Leaflet;
        atom Media;
        atom LeadArtist;
        atom Artist;
        atom Conductor;
        atom Band;
        atom Composer;
        atom Lyricist;
        atom RecordingLocation;
        atom DuringRecording;
        atom DuringPerformance;
        atom ScreenCapture;
        atom BrightFish;
        atom Illustration;
        atom BandLogo;
        atom PublisherLogo;
    }
}

#[derive(NifStruct)]
#[module = "ID3.Picture"]
/// Struct matching Elixir ID3's `Picture` struct.
pub struct ID3Picture {
    pub mime_type: String,
    pub picture_type: NifAtom,
    pub description: String,
    pub data: NifBinary, // not a valid String, but a elixir binary.
}

impl From<&Picture> for ID3Picture {
    fn from(pic: &Picture) -> Self {
        Self {
            mime_type: pic.mime_type.clone(),
            picture_type: from_picture_type(pic.picture_type),
            description: pic.description.clone(),
            data: NifBinary(pic.data.clone()),
        }
    }
}

impl From<ID3Picture> for Picture {
    fn from(pic: ID3Picture) -> Self {
        Self {
            mime_type: pic.mime_type,
            picture_type: to_picture_type(pic.picture_type),
            description: pic.description,
            data: pic.data.vec(), //unsafe { pic.data.clone().as_mut_vec().to_vec() },
        }
    }
}

fn from_picture_type(pic: PictureType) -> NifAtom {
    use id3::frame::PictureType::*;

    match pic {
        Icon => pictype_atoms::Icon(),
        OtherIcon => pictype_atoms::OtherIcon(),
        CoverFront => pictype_atoms::CoverFront(),
        CoverBack => pictype_atoms::CoverBack(),
        Leaflet => pictype_atoms::Leaflet(),
        Media => pictype_atoms::Media(),
        LeadArtist => pictype_atoms::LeadArtist(),
        Artist => pictype_atoms::Artist(),
        Conductor => pictype_atoms::Conductor(),
        Band => pictype_atoms::Band(),
        Composer => pictype_atoms::Composer(),
        Lyricist => pictype_atoms::Lyricist(),
        RecordingLocation => pictype_atoms::RecordingLocation(),
        DuringRecording => pictype_atoms::DuringRecording(),
        DuringPerformance => pictype_atoms::DuringPerformance(),
        ScreenCapture => pictype_atoms::ScreenCapture(),
        BrightFish => pictype_atoms::BrightFish(),
        Illustration => pictype_atoms::Illustration(),
        BandLogo => pictype_atoms::BandLogo(),
        PublisherLogo => pictype_atoms::PublisherLogo(),
        _ => pictype_atoms::Other(),
    }
}

fn to_picture_type(atom: NifAtom) -> PictureType {
    if atom == pictype_atoms::Icon() {
        PictureType::Icon
    } else if atom == pictype_atoms::OtherIcon() {
        PictureType::OtherIcon
    } else if atom == pictype_atoms::CoverFront() {
        PictureType::CoverFront
    } else if atom == pictype_atoms::CoverBack() {
        PictureType::CoverBack
    } else if atom == pictype_atoms::Leaflet() {
        PictureType::Leaflet
    } else if atom == pictype_atoms::Media() {
        PictureType::Media
    } else if atom == pictype_atoms::LeadArtist() {
        PictureType::LeadArtist
    } else if atom == pictype_atoms::Artist() {
        PictureType::Artist
    } else if atom == pictype_atoms::Conductor() {
        PictureType::Conductor
    } else if atom == pictype_atoms::Band() {
        PictureType::Band
    } else if atom == pictype_atoms::Composer() {
        PictureType::Composer
    } else if atom == pictype_atoms::Lyricist() {
        PictureType::Lyricist
    } else if atom == pictype_atoms::RecordingLocation() {
        PictureType::RecordingLocation
    } else if atom == pictype_atoms::DuringRecording() {
        PictureType::DuringRecording
    } else if atom == pictype_atoms::DuringPerformance() {
        PictureType::DuringPerformance
    } else if atom == pictype_atoms::ScreenCapture() {
        PictureType::ScreenCapture
    } else if atom == pictype_atoms::BrightFish() {
        PictureType::BrightFish
    } else if atom == pictype_atoms::Illustration() {
        PictureType::Illustration
    } else if atom == pictype_atoms::BandLogo() {
        PictureType::BandLogo
    } else if atom == pictype_atoms::PublisherLogo() {
        PictureType::PublisherLogo
    } else {
        PictureType::Other
    }
}

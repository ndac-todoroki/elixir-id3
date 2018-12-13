defmodule ID3V2 do
  @moduledoc """
  Read/Write ID3 tags.
  This module uses [`rust-id3`](https://github.com/jameshurst/rust-id3/) inside, so it follows the restrictions there.
  (Currently ID3v1/v2 reading is supported, and all writing will be done as ID3v2.4)

  ### Examples

  Modifying a tag.

      iex> {:ok, tag} = ID3V2.get_tag("audio.mp3")
      iex> new_tag = %{tag | year: 2018}
      iex> :ok = ID3V2.write_tag("audio.mp3", new_tag)

  ### Why read/write a struct?

  Since this is implemented as a NIF, read/writes will open and close the files every call. We could directly map functions in the `id3::Tag` crate, but it will lack performance, and is also unsafe to do that.

  Handling major frames combined as a `Tag` struct will let us allow to edit or copy them in Elixir/Erlang worlds, which is more pleasant for OTP users.

  """

  alias ID3V2.{Native, Tag}

  @doc """
  Reads a set of major frames from the given mp3 file, as a `Tag` struct.

  ### Examples

      iex> {:ok, tag} = ID3V2.get_tag("audio.mp3")
      iex> tag
      %ID3V2.Tag{
        album_artist: "Queen",
        artist: "Queen",
        date_recorded: ~N[1977-10-07 00:00:00],
        date_released: ~N[1981-11-02 00:00:00],
        disc: 1,
        duration: nil,
        genre: "Rock",
        title: "We Will Rock You",
        total_discs: 1,
        total_tracks: 17,
        track: 16,
        year: 1981
      }

      iex> ID3V2.get_tag("not_an_mp3.some")
      {:error, :file_open_error}

  """
  @spec get_tag(Path.t()) :: {:ok, Tag.t()} | {:error, :file_open_error}
  defdelegate get_tag(path), to: Native, as: :get_major_frames

  @doc """
  Writes a set of major tags to the given mp3 file.
  Setting `nil` for a certain key will remove the previously set value. *It won't bypass it.* Be careful!

  ### Examples

      iex> ID3V2.write_tag("audio.mp3", %{%ID3V2.Tag{} | year: 2016})
      :ok

  """
  @spec write_tag(Path.t(), Tag.t()) :: :ok | {:error, :file_open_error | :tag_write_error}
  defdelegate write_tag(path, tag), to: Native, as: :write_major_frames
end

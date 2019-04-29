defmodule ID3 do
  @moduledoc """
  Read/Write ID3 tags. All tags will be written as `ID3v2.4`.

  This module uses [`rust-id3`](https://github.com/jameshurst/rust-id3/) inside, so it follows the restrictions there.
  (Currently ID3v1/v2 reading is supported, and all writing will be done as ID3v2.4)

  ### Examples

  Modifying a tag.

      iex> {:ok, tag} = ID3.get_tag("audio.mp3")
      iex> new_tag = %{tag | year: 2018}
      iex> :ok = ID3.write_tag("audio.mp3", new_tag)

  ### Why read/write a struct?

  Since this is implemented as a NIF, read/writes will open and close the files every call.
  We could directly map functions in the `id3::Tag` crate, but it will lack performance, and is also unsafe to do that.

  Handling major frames combined as a `Tag` struct will let us allow to edit or copy them in Elixir/Erlang worlds, which is more pleasant for OTP users.

  """

  alias ID3.{Native, Tag}

  @doc """
  Reads a set of major frames from the given mp3 file, as a `Tag` struct.

  ### Examples

      iex> {:ok, tag} = ID3.get_tag("audio.mp3")
      iex> tag
      %ID3.Tag{
        album_artist: "Queen",
        artist: "Queen",
        date_recorded: ~N[1977-10-07 00:00:00],
        date_released: ~N[1981-11-02 00:00:00],
        disc: 1,
        duration: nil,
        genre: "Rock",
        pictures: [
          %ID3.Picture{
            data: <<255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 72, 0,
              72, 0, 0, 255, 225, 3, 88, 69, 120, 105, 102, 0, 0, 77, 77, 0, 42, 0, 0,
              0, 8, 0, 9, ...>>,
            description: "",
            mime_type: "image/jpeg",
            picture_type: :CoverFront
          }
        ],
        title: "We Will Rock You",
        total_discs: 1,
        total_tracks: 17,
        track: 16,
        year: 1981
      }

      iex> ID3.get_tag("not_an_mp3.some")
      {:error, :file_open_error}

  """
  @spec get_tag(Path.t()) :: {:ok, Tag.t()} | {:error, :file_open_error}
  defdelegate get_tag(path), to: Native, as: :get_major_frames

  def get_tag!(path), do: get_tag(path) |> bangify!

  @doc """
  Writes a set of major tags to the given mp3 file.
  Setting `nil` for a certain key will remove the previously set value. *It won't bypass it.* Be careful!

  ### Examples

      iex> ID3.write_tag(%{ID3.Tag.new() | year: 2016}, "audio.mp3")  # removes other tags of "audio.mp3" too.
      :ok

  """
  @spec write_tag(Tag.t(), Path.t()) :: :ok | {:error, :file_open_error | :tag_write_error}
  defdelegate write_tag(tag, path), to: Native, as: :write_major_frames

  def write_tag!(tag, path), do: write_tag(tag, path) |> bangify!

  defmodule TagIOError do
    defexception [:message]

    def exception(value) do
      msg = "Panic reading tags. Rust ID3 error: #{inspect(value)}"
      %__MODULE__{message: msg}
    end
  end

  defp bangify!({:ok, term}), do: term
  defp bangify!({:error, msg}), do: raise(TagIOError, msg)
end

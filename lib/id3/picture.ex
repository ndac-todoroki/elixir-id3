defmodule ID3.Picture do
  @moduledoc """
  A struct representing a picture in the ID3 tag.
  See https://docs.rs/id3/0.3.0/id3/frame/struct.Picture.html

  ### PictureType
  Due to limitations of `rust-id3`, multiple pictures with same `picture_type` is not available.
  When writing, a picture with the same `picture_type` within the existing tab, will overwrite that picture.
  When reading, `rust-id3` only returns one of the picture of the same type.
  """

  defstruct mime_type: nil, picture_type: nil, description: "", data: nil

  @typedoc """
  A structure representing an ID3 picture frame's contents.

  - `data` is a binary of unsigned char(8bit)s.
  - `picture_type` will be `:Other` otherwise correctly given.
  """
  @type t :: %__MODULE__{
          mime_type: String.t(),
          picture_type: picture_type,
          description: String.t(),
          data: :binary
        }

  @picture_types ~W(
    Other Icon OtherIcon
    CoverFront CoverBack
    Leaflet Media LeadArtist
    Conductor Band Composer Lyricist
    RecordingLocation DuringRecording DuringPerformance
    ScreenCapture BrightFish
    Illustration BandLogo PublisherLogo
  )a

  @typedoc """
  Types of pictures used in APIC frames.
  """
  @type picture_type ::
          :Other
          | :Icon
          | :OtherIcon
          | :CoverFront
          | :CoverBack
          | :Leaflet
          | :Media
          | :LeadArtist
          | :Conductor
          | :Band
          | :Composer
          | :Lyricist
          | :RecordingLocation
          | :DuringRecording
          | :DuringPerformance
          | :ScreenCapture
          | :BrightFish
          | :Illustration
          | :BandLogo
          | :PublisherLogo

  @doc """
  Creates a new Picture.

  Needs the data binary and the MIME type of the data.

  ## Options
  - `picture_type`: ID3 tags can have a picture for each type. One of `t:Picture.picture_type/0`.
  - `description`: Text description about the picture.

  ## Examples
      iex> data = File.read!("full/path/to/foo.jpg")
      iex> ID3.Picture.new(data, "image/jpeg", picture_type: :CoverFront)
      {:ok,
        %ID3.Picture{
          data: <<255, 167, ...>>,
          description: "",
          mime_type: "image/jpeg",
          picture_type: :CoverFront
        }
      }
  """
  @spec new(binary, String.t(), options :: [option]) :: {:ok, Picture.t()} | :error
        when option: {:picture_type, picture_type()} | {:description, String.t()}
  def new(data, mime_type, options \\ [])
      when data |> is_binary and mime_type |> is_binary and options |> is_list do
    picture_type = options |> Keyword.get(:picture_type, :Other)
    description = options |> Keyword.get(:description, "")

    with true <- @picture_types |> Enum.member?(picture_type),
         true <- description |> String.valid?() do
      picture = %__MODULE__{
        picture_type: picture_type,
        mime_type: mime_type,
        description: "",
        data: data
      }

      {:ok, picture}
    else
      _ -> :error
    end
  end
end

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

  def new(data) when data |> is_binary do
    %__MODULE__{
      picture_type: :Other,
      mime_type: "",
      description: "",
      data: data
    }
  end
end

defmodule ID3.Picture do
  @moduledoc """
  A struct representing a picture in the ID3 tag.
  See https://docs.rs/id3/0.3.0/id3/frame/struct.Picture.html
  """

  defstruct mime_type: nil, picture_type: nil, description: "", data: nil

  @typedoc """
  A structure representing an ID3 picture frame's contents.
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

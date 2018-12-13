defmodule ID3.Tag do
  @moduledoc """
  `ID3.Tag` struct represents the set of major frames supported directly by rust-id3. This is always ID3v2.4.

  This struct must match / be matched by the Rust Nif's struct.
  """

  defstruct [
    # :comments,
    # :lyrics,
    # :pictures,
    :year,
    :date_recorded,
    :date_released,
    :artist,
    :album_artist,
    :title,
    :duration,
    :genre,
    :disc,
    :total_discs,
    :track,
    :total_tracks
  ]

  @type t :: %__MODULE__{
          # comments: String.t() | nil,
          # lyrics: String.t() | nil,
          # pictures: [Picture.t()],
          year: integer | nil,
          date_recorded: NaiveDateTime.t() | nil,
          date_released: NaiveDateTime.t() | nil,
          artist: String.t() | nil,
          album_artist: String.t() | nil,
          title: String.t() | nil,
          duration: non_neg_integer | nil,
          genre: String.t() | nil,
          disc: non_neg_integer | nil,
          total_discs: non_neg_integer | nil,
          track: non_neg_integer | nil,
          total_tracks: non_neg_integer | nil
        }
end

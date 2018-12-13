# ID3

Read/Write mp3 ID3 tags. Using Rust and Rustler as a backbone.

This module uses [`rust-id3`](https://github.com/jameshurst/rust-id3/) inside, so it follows the restrictions there.
(Currently ID3v1/v2 reading is supported, and all writing will be done as ID3v2.4)

## Example

```elixir
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
  title: "We Will Rock You",
  total_discs: 1,
  total_tracks: 17,
  track: 16,
  year: 1981
}
```

Read the [Documents](https://hexdocs.pm/id3/ID3.html) to know how to use.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `id3` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:id3, "~> 0.1.0"}
  ]
end
```

Before doing `mix deps.get`, make sure you have the latest Rust installed on your environment. The stable build should be good enough.

If first time playing with Rust, install `rustup`. Follow the instructions and it will install the latest stable Rust too.

## Hey, this is slow :(

Maybe you are booting your application *not* in `:prod` mode.
When `ID3` is compiled in `:prod` mode, the Rust source will be compiled in "release" mode, which makes it optimized for performance.

If you're already doing that and still is slow, report me, or please feel free to contribute :)
Both Elixir and Rust aspects of this library may be the problem.

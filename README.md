# ID3

Read/Write mp3 ID3 tags. Using Rust and Rustler as a backbone.

This module uses [`rust-id3`](https://github.com/jameshurst/rust-id3/) inside, so it follows the restrictions there.
(Currently ID3v1/v2 reading is supported, and all writing will be done as ID3v2.4)

Read the [Documents](https://hexdocs.pm/id3) to know how to use.

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

defmodule ID3.MixProject do
  use Mix.Project

  def project do
    [
      app: :id3,
      version: "1.0.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      rustler_crates: rustler_crates(),
      compilers: [:rustler] ++ Mix.compilers(),
      deps: deps(),

      # Docs
      name: "ID3",
      source_url: "https://github.com/ndac-todoroki/elixir-id3",
      # homepage_url: "http://YOUR_PROJECT_HOMEPAGE",
      docs: [
        # The main page in the docs
        main: "ID3",
        # logo: "path/to/logo.png",
        extras: ["README.md"]
      ],

      # Hex.pm
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:rustler, "~> 0.22.0"}
    ]
  end

  defp rustler_crates do
    [
      id3: [
        path: "native/id3",
        mode: if(Mix.env() == :prod, do: :release, else: :debug)
      ]
    ]
  end

  defp description() do
    "Read/Write mp3 ID3 tags. Uses Rust NIF."
  end

  defp package() do
    [
      files: ~w(lib native .formatter.exs mix.exs README* LICENSE*
                CHANGELOG*),
      exclude_patterns: ~w(native/id3/target),
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/ndac-todoroki/elixir-id3"
      }
    ]
  end
end

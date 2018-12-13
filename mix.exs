defmodule ID3V2.MixProject do
  use Mix.Project

  def project do
    [
      app: :id3v2,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      rustler_crates: rustler_crates(),
      compilers: [:rustler] ++ Mix.compilers(),
      deps: deps(),

      # Docs
      name: "ID3V2",
      source_url: "https://github.com/ndac_todoroki/elixir-id3v2",
      # homepage_url: "http://YOUR_PROJECT_HOMEPAGE",
      docs: [
        # The main page in the docs
        main: "ID3V2",
        # logo: "path/to/logo.png",
        extras: ["README.md"]
      ]
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
      {:rustler, "0.18.0"}
    ]
  end

  defp rustler_crates do
    [
      id3v2: [
        path: "native/id3v2",
        mode: if(Mix.env() == :prod, do: :release, else: :debug)
      ]
    ]
  end
end

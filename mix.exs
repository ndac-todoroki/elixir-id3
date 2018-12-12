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
      deps: deps()
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

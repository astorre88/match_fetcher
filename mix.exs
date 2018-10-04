defmodule MatchFetcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :match_fetcher,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {MatchFetcher, []},
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Core
      {:jason, "~> 1.1"},
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.11"},

      # Testing
      {:ex_machina, "~> 2.2"}
    ]
  end

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end

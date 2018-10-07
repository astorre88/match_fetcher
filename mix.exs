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
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      aliases: aliases(),

      # Docs
      name: "MatchFetcher",
      source_url: "https://bitbucket.org/astorre/match_fetcher"
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
      {:poison, "~> 3.1"},
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.11"},

      # Linters
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false},

      # Testing and documenting
      {:ex_machina, "~> 2.2"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:inch_ex, github: "rrrene/inch_ex", only: [:dev, :test]},

      # Test coverage
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end

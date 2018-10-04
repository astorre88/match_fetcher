use Mix.Config

config :match_fetcher, MatchFetcher.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "match_fetcher_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :match_fetcher, ecto_repos: [MatchFetcher.Repo]

import_config "#{Mix.env()}.exs"

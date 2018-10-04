use Mix.Config

config :match_fetcher,
  fetch_period: "1000"

config :match_fetcher,
       MatchFetcher.Provider.Action,
       client: MatchFetcher.Provider.Clients.Stub

config :logger, level: :warn

config :match_fetcher, MatchFetcher.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "match_fetcher_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

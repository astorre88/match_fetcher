use Mix.Config

config :match_fetcher,
  fetch_period: "1000"

config :match_fetcher,
       MatchFetcher.Provider.Action,
       client: MatchFetcher.Provider.Clients.Stub

config :logger, :console, format: "[$level] $message\n"

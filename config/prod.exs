use Mix.Config

config :match_fetcher,
  fetch_period: 30_000

config :match_fetcher,
       MatchFetcher.Provider.Action,
       client: MatchFetcher.Provider.Clients.Basic

config :logger, level: :info

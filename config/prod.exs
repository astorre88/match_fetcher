use Mix.Config

config :match_fetcher,
  fetch_period: System.get_env("FETCH_PERIOD")

config :match_fetcher,
       MatchFetcher.Provider.Action,
       client: MatchFetcher.Provider.Clients.Basic

config :logger, level: :info

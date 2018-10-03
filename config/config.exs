use Mix.Config

config :match_fetcher,
  fetch_period: System.get_env("FETCH_PERIOD")

import_config "#{Mix.env()}.exs"

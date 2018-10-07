defmodule MatchFetcher do
  @moduledoc """
  Application supervisor module. Starts fetcher process.
  """

  use Application

  @spec start(any(), any()) :: {:error, any()} | {:ok, pid()}
  def start(_type, _args) do
    providers_config = [
      [
        name: "Matchbeam",
        url: "http://forzaassignment.forzafootball.com:4040/feed/matchbeam"
      ],
      [
        name: "FastBall",
        url: "http://forzaassignment.forzafootball.com:4040/feed/fastball",
        offset_option: "last_checked_at"
      ]
    ]

    start_providers(providers_config)
  end

  @spec start_providers(any()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_providers(providers_config) do
    MatchFetcher.Supervisor.start_link(providers_config)
  end
end

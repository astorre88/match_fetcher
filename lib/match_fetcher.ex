defmodule MatchFetcher do
  @moduledoc """
  Application supervisor module. Starts fetcher process.
  """

  use Application

  @spec start(any(), any()) :: {:error, any()} | {:ok, pid()}
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(MatchFetcher.Fetcher, [])
    ]

    opts = [strategy: :one_for_one, name: MatchFetcher.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

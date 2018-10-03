defmodule MatchFetcher.Supervisor do
  use Supervisor

  @spec start_link(any()) :: {:error, any()} | {:ok, pid()}
  def start_link(providers_config) do
    Supervisor.start_link(__MODULE__, providers_config, name: __MODULE__)
  end

  def init(providers_config) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: MatchFetcher.ProvidersSupervisor},
      %{
        id: MatchFetcher.Server,
        start: {MatchFetcher.Server, :start_link, [providers_config]}
      }
    ]

    opts = [strategy: :one_for_all]

    Supervisor.init(children, opts)
  end
end

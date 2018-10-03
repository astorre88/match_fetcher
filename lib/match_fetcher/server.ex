defmodule MatchFetcher.Server do
  use GenServer

  # API

  @spec start_link(any()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(providers_config) do
    GenServer.start_link(__MODULE__, providers_config, name: __MODULE__)
  end

  # Server

  @spec init(any()) :: {:ok, any()}
  def init(providers_config) do
    providers_config
    |> Enum.each(fn provider_config ->
      send(self(), {:start_provider, provider_config})
    end)

    {:ok, providers_config}
  end

  def handle_info({:start_provider, provider_config}, state) do
    {:ok, _wid} = MatchFetcher.ProvidersSupervisor.add_provider(provider_config)
    {:noreply, state}
  end
end
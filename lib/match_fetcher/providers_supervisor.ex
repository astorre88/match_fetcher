defmodule MatchFetcher.ProvidersSupervisor do
  use DynamicSupervisor

  @spec start_link() :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @spec add_provider(any()) ::
          {:error, any()} | {:ok, :undefined | pid()} | {:ok, :undefined | pid(), any()}
  def add_provider(provider) do
    spec = {MatchFetcher.Fetcher, provider}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  @spec init(any()) ::
          {:ok,
           %{
             extra_arguments: [any()],
             intensity: non_neg_integer(),
             max_children: :infinity | non_neg_integer(),
             period: pos_integer(),
             strategy: :one_for_one
           }}
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end

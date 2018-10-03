defmodule MatchFetcher.Fetcher do
  @moduledoc """
  Provider fetching process. Fetches provider data.
  """

  use GenServer

  # API

  @spec start_link() :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # Server

  @impl true
  @spec init(:ok) :: {:ok, 0}
  def init(:ok) do
    fetch_data()
    {:ok, 0}
  end

  @impl true
  def handle_info(:fetch, state) do
    spawn_link(&do_request/0)
    fetch_data()
    {:noreply, state}
  end

  defp do_request() do
  end

  defp fetch_data() do
    Process.send_after(self(), :fetch, String.to_integer(Application.get_env(:match_fetcher, :fetch_period)))
  end
end

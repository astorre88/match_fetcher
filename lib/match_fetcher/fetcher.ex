defmodule MatchFetcher.Fetcher do
  @moduledoc """
  Long-polling process. Fetches provider data periodicaly.
  """

  use GenServer

  alias MatchFetcher.Provider

  # API

  @spec start_link(nil | keyword() | map()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(provider_config) do
    GenServer.start_link(__MODULE__, provider_config[:url],
      name: :"#{provider_config[:name]}Worker"
    )
  end

  # Server

  @impl true
  @spec init(any()) :: {:ok, any()}
  def init(url) do
    fetch_data()
    {:ok, url}
  end

  @impl true
  def handle_info(:fetch, url) do
    spawn_link(__MODULE__, :do_request, [url])
    fetch_data()
    {:noreply, url}
  end

  @spec do_request(any()) :: any()
  def do_request(url) do
    IO.inspect(url)
    # Provider.fetch(url) |> IO.inspect
  end

  defp fetch_data() do
    Process.send_after(
      self(),
      :fetch,
      String.to_integer(Application.get_env(:match_fetcher, :fetch_period))
    )
  end
end

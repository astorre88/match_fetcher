defmodule MatchFetcher.Fetcher do
  @moduledoc """
  Long-polling process. Fetches provider data periodicaly.
  """

  defmodule State do
    @moduledoc false
    @enforce_keys [:name, :url]
    defstruct [:name, :url, :offset_option, :offset_value]
  end

  use GenServer

  require Logger

  alias MatchFetcher.Matches
  alias MatchFetcher.Provider
  alias MatchFetcher.Provider.Protocols.Response

  # API

  @spec start_link(nil | keyword() | map()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(provider_config) do
    GenServer.start_link(__MODULE__, struct(State, provider_config),
      name: :"#{provider_config[:name]}Worker"
    )
  end

  # Server

  @impl true
  @spec init(any()) :: {:ok, any()}
  def init(provider_config) do
    run_fetch_process()
    {:ok, add_offset(provider_config)}
  end

  @impl true
  def handle_info(:fetch, provider_config) do
    spawn_link(__MODULE__, :do_request, [self(), provider_config])
    run_fetch_process()
    {:noreply, provider_config}
  end

  @impl true
  def handle_info(:update_offset, provider_config) do
    {:noreply, add_offset(provider_config)}
  end

  @spec do_request(any(), atom() | %{url: any()}) :: any()
  def do_request(pid, provider_config) do
    provider_config
    |> Provider.fetch()
    |> save_results()

    Process.send(pid, :update_offset, [])
  end

  defp add_offset(provider_config) do
    case Matches.last_match() do
      nil ->
        provider_config

      match ->
        %{provider_config | offset_value: match.created_at}
    end
  end

  defp run_fetch_process do
    Process.send_after(
      self(),
      :fetch,
      Application.get_env(:match_fetcher, :fetch_period)
    )
  end

  defp save_results({:ok, matches}) do
    matches
    |> Enum.map(&Response.normalize(&1))
    |> Matches.create_matches()
  end

  defp save_results({:error, reason}) do
    Logger.error("Error: " <> reason)
  end
end

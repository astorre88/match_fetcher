defmodule MatchFetcher.Provider.Clients.Basic do
  @moduledoc """
  HTTP basic client.
  """

  @behaviour MatchFetcher.Provider.Client

  def request(url) do
    Application.ensure_all_started(:inets)

    case :httpc.request(:get, {url, []}, [{:timeout, :timer.seconds(5)}], []) do
      {:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}} ->
        {:ok, body}

      {:error, resp} ->
        case resp do
          :timeout ->
            {:error, "ERROR Response: timeout"}

          resp_tuple ->
            {:error, "ERROR Response: #{resp_tuple |> Tuple.to_list() |> hd}"}
        end
    end
  end
end

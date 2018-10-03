defmodule MatchFetcher.Provider do
  @moduledoc """
  Provider fetching process. Makes provider data request.
  """

  use MatchFetcher.Provider.Action

  @spec fetch(any()) :: any()
  def fetch(url) do
    url
    |> to_charlist()
    |> @http_client.request()
    |> parse_response()
  end

  defp parse_response({:ok, body}) do
    body =
      body
      |> to_string
      |> Jason.decode!()

    {:ok, body}
  end

  defp parse_response(response), do: response
end

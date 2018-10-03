defmodule MatchFetcher.Provider.Client do
  @moduledoc """
  HTTP client behaviour.
  """

  @doc """
  HTTP-request to chosen provider. Returns JSON response.
  """
  @callback request(url :: charlist()) :: {:ok, response :: map()} | {:error, String.t()}
end

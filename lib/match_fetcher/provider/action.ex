defmodule MatchFetcher.Provider.Action do
  @moduledoc """
  The `using` for the wrapping HTTP-requests.

  ## Example

  You can create the wrapper around `SomeAction` service.
  It returns raw HTTP-request result.

  ```elixir
  defmodule use MatchFetcher.Provider.Actions.SomeAction do
    use MatchFetcher.Provider.Action

    def fetch(params) do
      @http_client.request(url)
    end
  end
  ```
  """

  @doc """
  The macros which creates helper module attribute:

  * `@http_client` - used realization of `MatchFetcher.Provider.Client`
  """
  defmacro __using__(_opts) do
    http_client = Application.fetch_env!(:match_fetcher, __MODULE__)[:client]

    quote location: :keep, bind_quoted: [http_client: http_client] do
      @behaviour MatchFetcher.Provider.Action

      @http_client http_client
    end
  end
end

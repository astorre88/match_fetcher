defmodule MatchFetcher.Provider.Action do
  defmacro __using__(_opts) do
    http_client = Application.fetch_env!(:match_fetcher, __MODULE__)[:client]

    quote location: :keep, bind_quoted: [http_client: http_client] do
      @behaviour MatchFetcher.Provider.Action

      @http_client http_client
    end
  end
end

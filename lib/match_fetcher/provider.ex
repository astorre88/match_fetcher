defmodule MatchFetcher.Provider do
  @moduledoc """
  Provider fetching process. Makes provider data request.
  """

  use MatchFetcher.Provider.Action

  @spec fetch(any()) :: any()
  def fetch(provider_config) do
    provider_config.url
    |> prepare_url(provider_config)
    |> @http_client.request()
    |> parse_response(provider_config)
  end

  defp prepare_url(url, %{offset_option: nil}), do: to_charlist(url)
  defp prepare_url(url, %{offset_value: nil}), do: to_charlist(url)

  defp prepare_url(url, provider_config) do
    to_charlist(
      "#{url}?#{provider_config.offset_option}=#{DateTime.to_unix(provider_config.offset_value)}"
    )
  end

  defp parse_response({:ok, body}, provider_config) do
    body =
      body
      |> to_string()
      |> Poison.decode!(
        as: %{"matches" => [struct(:"Elixir.MatchFetcher.#{provider_config.name}")]}
      )
      |> Map.get("matches")
      |> shift_by_offset(provider_config)

    {:ok, body}
  end

  defp parse_response({:error, body}, _name), do: {:error, to_string(body)}

  defp shift_by_offset(body, %{offset_value: nil}), do: body

  defp shift_by_offset(body, %{offset_option: nil} = provider_config) do
    Enum.drop_while(body, &(&1 < provider_config.offset_value))
  end

  defp shift_by_offset(body, _provider_config), do: body
end

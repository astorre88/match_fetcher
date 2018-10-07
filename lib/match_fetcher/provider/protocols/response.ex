defprotocol MatchFetcher.Provider.Protocols.Response do
  @moduledoc """
  Protocol for handling different providers responses.
  """

  @spec normalize(any()) :: any()
  def normalize(response)
end

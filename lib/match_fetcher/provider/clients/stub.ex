defmodule MatchFetcher.Provider.Clients.Stub do
  @moduledoc """
  HTTP stub-client.
  """

  @behaviour MatchFetcher.Provider.Client

  def request('http://forzaassignment.forzafootball.com:4040/feed/matchbeam') do
    {
      :ok,
      ~s({"matches": [{"teams": "Arsenal - Chelsea FC", "created_at": 1515503067}]})
    }
  end

  def request('http://forzaassignment.forzafootball.com:4040/feed/fastball') do
    {
      :ok,
      ~s({"matches": [{"home_team": "Arsenal", "away_team": "Chelsea FC", "created_at": 1515503067}]})
    }
  end

  def request('http://forzaassignment.forzafootball.com:4040/feed/fastball' ++ _offset_option) do
    {
      :ok,
      ~s({"matches": [{"home_team": "Abc", "away_team": "Def", "created_at": 1515503099}]})
    }
  end

  def request(_) do
    {:error, "ERROR Response: failed_connect"}
  end
end

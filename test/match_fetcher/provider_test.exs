defmodule MatchFetcher.ProviderTest do
  use ExUnit.Case

  alias MatchFetcher.Provider

  test "fetches matchbeam json response" do
    response = Provider.fetch("http://forzaassignment.forzafootball.com:4040/feed/matchbeam")

    assert response == {
             :ok,
             [
               %{
                 "teams" => "Arsenal - Chelsea FC",
                 "created_at" => 1_515_503_067
               }
             ]
           }
  end

  test "fetches fastball json response" do
    response = Provider.fetch("http://forzaassignment.forzafootball.com:4040/feed/fastball")

    assert response == {
             :ok,
             [
               %{
                 "home_team" => "Arsenal",
                 "away_team" => "Chelsea FC",
                 "created_at" => 1_515_503_067
               }
             ]
           }
  end

  test "returns error" do
    response = Provider.fetch("wrong_url")

    assert response == {
             :error,
             "ERROR Response: failed_connect"
           }
  end
end

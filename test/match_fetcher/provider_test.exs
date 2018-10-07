defmodule MatchFetcher.ProviderTest do
  use MatchFetcher.RepoCase

  import MatchFetcher.MatchFactory

  alias MatchFetcher.FastBall
  alias MatchFetcher.Fetcher.State
  alias MatchFetcher.Matchbeam
  alias MatchFetcher.Provider

  test "fetches matchbeam json response" do
    insert(:match)
    insert(:match)

    response =
      Provider.fetch(%State{
        name: "Matchbeam",
        url: "http://forzaassignment.forzafootball.com:4040/feed/matchbeam"
      })

    assert response ==
             {:ok, [%Matchbeam{created_at: 1_515_503_067, teams: "Arsenal - Chelsea FC"}]}
  end

  test "fetches fastball json response" do
    insert(:match)

    response =
      Provider.fetch(%State{
        name: "FastBall",
        url: "http://forzaassignment.forzafootball.com:4040/feed/fastball",
        offset_option: "last_checked_at",
        offset_value: DateTime.utc_now()
      })

    assert response ==
             {:ok,
              [
                %FastBall{
                  away_team: "Def",
                  created_at: 1_515_503_099,
                  home_team: "Abc"
                }
              ]}
  end

  test "returns error" do
    response = Provider.fetch(%State{name: "FastBall", url: "wrong_url"})

    assert response == {:error, "ERROR Response: failed_connect"}
  end
end

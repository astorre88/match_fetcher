defmodule MatchFetcher.MatchesTest do
  use MatchFetcher.RepoCase

  import MatchFetcher.MatchFactory

  alias MatchFetcher.Matches

  describe "matches" do
    alias MatchFetcher.Matches.Match

    @valid_attrs %{
      home_team: "Arsenal",
      away_team: "Chelsea FC",
      created_at: DateTime.from_unix!(1_515_503_067)
    }
    @invalid_attrs %{home_team: "Arsenal"}

    test "last_match/0 returns the last match" do
      _match1 = insert(:match)
      _match2 = insert(:match)
      match3 = insert(:match)

      assert Map.delete(Matches.last_match(), :created_at) == match3 |> Map.delete(:created_at)
    end

    test "create_match/1 with valid data creates a match" do
      assert {:ok, %Match{} = match} = Matches.create_match(@valid_attrs)
      assert match.home_team == "Arsenal"
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Matches.create_match(@invalid_attrs)
    end
  end
end

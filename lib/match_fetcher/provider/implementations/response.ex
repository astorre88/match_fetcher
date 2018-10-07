defimpl MatchFetcher.Provider.Protocols.Response, for: MatchFetcher.Matchbeam do
  @doc """
  Implementation of response normalization protocol for the Matchbeam provider.
  """
  def normalize(match) do
    [home_team, away_team] = split_teams(match.teams)

    %{
      home_team: home_team,
      away_team: away_team,
      created_at: DateTime.from_unix!(match.created_at)
    }
  end

  defp split_teams(teams) do
    String.split(teams, " - ")
  end
end

defimpl MatchFetcher.Provider.Protocols.Response, for: MatchFetcher.FastBall do
  @doc """
  Implementation of response normalization protocol for the FastBall provider.
  """
  def normalize(match) do
    %{
      home_team: match.home_team,
      away_team: match.away_team,
      created_at: DateTime.from_unix!(match.created_at)
    }
  end
end

defmodule MatchFetcher.MatchFactory do
  @moduledoc false

  use ExMachina.Ecto, repo: MatchFetcher.Repo

  alias MatchFetcher.Matches.Match

  @spec match_factory() :: MatchFetcher.Matches.Match.t()
  def match_factory do
    %Match{
      home_team: "Arsenal",
      away_team: "Chelsea FC",
      created_at: DateTime.utc_now()
    }
  end
end

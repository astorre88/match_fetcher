defmodule MatchFetcher.FastBall do
  @moduledoc false

  @derive [Poison.Encoder]
  defstruct [:home_team, :away_team, :created_at]
end

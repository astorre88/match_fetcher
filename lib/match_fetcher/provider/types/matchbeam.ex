defmodule MatchFetcher.Matchbeam do
  @moduledoc false

  @derive [Poison.Encoder]
  defstruct [:teams, :created_at]
end

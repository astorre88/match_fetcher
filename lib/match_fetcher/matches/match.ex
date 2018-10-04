defmodule MatchFetcher.Matches.Match do
  use Ecto.Schema

  schema "matches" do
    field(:home_team, :string)
    field(:away_team, :string)
    field(:created_at, :utc_datetime)
  end

  @spec changeset(
          {map(), map()} | %{:__struct__ => atom(), optional(atom()) => any()},
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(match, params \\ %{}) do
    match
    |> Ecto.Changeset.cast(params, [:home_team, :away_team, :created_at])
    |> Ecto.Changeset.validate_required([:home_team, :away_team, :created_at])
  end
end

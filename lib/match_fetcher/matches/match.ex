defmodule MatchFetcher.Matches.Match do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

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
    |> cast(params, [:home_team, :away_team, :created_at])
    |> validate_required([:home_team, :away_team, :created_at])
    |> unique_constraint(:created_at, name: :index_matches_on_event)
  end
end

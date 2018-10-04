defmodule MatchFetcher.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :home_team, :string, null: false
      add :away_team, :string, null: false
      add :created_at, :utc_datetime, null: false
    end

    create index(:matches, [:created_at])
  end
end

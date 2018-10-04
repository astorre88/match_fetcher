defmodule MatchFetcher.Matches do
  @moduledoc """
  The Matches context.
  """

  import Ecto.Query, warn: false

  alias MatchFetcher.Matches.Match
  alias MatchFetcher.Repo

  @doc """
  Creates a match.

  ## Examples

      iex> create_match(%{away_team: "Chelsea FC", home_team: "Arsenal", created_at: DateTime.from_unix!(1_515_503_067)})
      {:ok, %Event{}}

      iex> create_match(%{away_team: "Chelsea FC"})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_match(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  def create_match(attrs \\ %{}) do
    %Match{}
    |> Match.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets the last match.

  ## Examples

      iex> last_match()
      %Event{}

      iex> last_match()
      nil

  """
  @spec last_match() :: any()
  def last_match do
    Repo.one(from(m in Match, order_by: [desc: m.created_at], limit: 1))
  end
end

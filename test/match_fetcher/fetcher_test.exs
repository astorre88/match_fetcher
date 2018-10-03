defmodule MatchFetcher.FetcherTest do
  use ExUnit.Case

  alias MatchFetcher.Fetcher

  setup do
    start_supervised(Fetcher)
    :ok
  end

  test "fetcher already started" do
    assert {:error, {:already_started, pid}} = Fetcher.start_link([])
  end
end

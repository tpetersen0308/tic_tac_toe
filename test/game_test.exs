defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "it can return the number of turns played so far" do
    board = Board.empty
    board = Board.update(board, 5, "X") |> Board.update(8, "O") |> Board.update(2, "X")

    assert 3 == Game.turn_count(board)
  end
end
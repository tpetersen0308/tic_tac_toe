defmodule GameManagerTest do
  use ExUnit.Case
  import Mock
  import GameManager
  doctest GameManager

  describe "GameManager.turn" do
    test_with_mock "it prompts the user for input", GameIO, [get_input: fn(_) -> nil end] do
      board = Board.empty()
      turn(board)
      assert called GameIO.get_input("X")
    end

    test_with_mock "it prompts the user for input with a properly interpolated message", GameIO, [get_input: fn(_) -> nil end] do
      board = Board.empty() |> Board.update(5, "X")
      turn(board)
      assert called GameIO.get_input("O")
    end
  end
end 
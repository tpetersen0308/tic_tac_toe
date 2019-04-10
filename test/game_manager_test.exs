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
  end
end 
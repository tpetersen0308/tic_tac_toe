defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "it can return the number of turns played so far" do
    board = Board.empty
    board = Board.update(board, 5, "X") |> Board.update(8, "O") |> Board.update(2, "X")

    assert 3 == Game.turn_count(board)
  end

  describe "Board.current_player" do
    board = Board.empty
    board = Board.update(board, 5, "X") |> Board.update(8, "O") |> Board.update(2, "X")
    
    test "it returns 'O' when the turn count is odd" do
      assert "O" == Game.current_player(unquote(Macro.escape(board)))
    end

    board = Board.update(board, 6, "O")
    
    test "it returns 'X' when the turn count is even" do
      assert "X" == Game.current_player(unquote(Macro.escape(board)))
    end
  end

  test "it can determine if the game has been won across the top row" do
    board = Board.empty
    board = Board.update(board, 1, "X") 
      |> Board.update(8, "O") 
      |> Board.update(2, "X") 
      |> Board.update(9, "O")
      |> Board.update(3, "X")

    assert Game.check_win(board)
  end
end
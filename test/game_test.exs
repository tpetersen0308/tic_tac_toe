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

  describe "Game.check_win" do
    test "it will not identify nil series as a win" do
      board = Board.empty

      assert !Game.check_win(board)
    end

    Enum.each(%{
      "top row" => {1,2,3},
      "middle row" => {4,5,6}
    }, fn {type, combo} ->
        test "it can determine a #{type} win" do
          board = Board.empty
            |> Board.update(elem(unquote(Macro.escape(combo)), 0), "X")
            |> Board.update(elem(unquote(Macro.escape(combo)), 1), "X")
            |> Board.update(elem(unquote(Macro.escape(combo)), 2), "X")

          assert Game.check_win(board)
        end 
      end
    )
  end
end
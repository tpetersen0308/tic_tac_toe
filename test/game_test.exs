defmodule GameTest do
  use ExUnit.Case
  doctest Game

  @empty_board Board.empty
  @cats_game_board %{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"}

  test "it can return the number of turns played so far" do
    board = @empty_board
    board = Board.update(board, 5, "X") |> Board.update(8, "O") |> Board.update(2, "X")

    assert 3 == Game.turn_count(board)
  end

  describe "Game.is_board_full" do
    test "it returns true for a full board" do
      assert Game.is_board_full(@cats_game_board)
    end

    test "it returns false for a board that has at least one available position" do
      assert !Game.is_board_full(Board.update(@cats_game_board, 6, nil))
    end
  end

  describe "Board.current_player" do
    board = @empty_board
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
      board = @empty_board

      assert !Game.check_win(board)
    end

    Enum.each(%{
      "top row" => {1, 2, 3},
      "middle row" => {4, 5, 6},
      "bottom row" => {7, 8, 9},
      "left column" => {1, 4, 7},
      "middle column" => {2, 5, 8},
      "right column" => {3, 6, 9},
      "NW to SE diagonal" => {1, 5, 9},
      "SW to NE diagonal" => {3, 5, 7}
    }, fn {type, combo} ->
        test "it can determine a #{type} win" do
          board = @empty_board
            |> Board.update(elem(unquote(Macro.escape(combo)), 0), "X")
            |> Board.update(elem(unquote(Macro.escape(combo)), 1), "X")
            |> Board.update(elem(unquote(Macro.escape(combo)), 2), "X")

          assert Game.check_win(board)
        end 
      end
    )
  end

  test "it can check for a draw" do
    assert Game.check_draw(@cats_game_board)
  end

  describe "Game.is_over" do
    test "it can tell when the game has ended in a cats game" do
      assert Game.is_over(@cats_game_board)
    end

    test "it can tell when the game has ended in a win" do
      board = %{ 1 => "X", 2 => "X", 3 => "O", 4 => "O", 5 => "X", 6 => "X", 7 => "O", 8 => "X", 9 => "O"}

      assert Game.is_over(board)
    end
  end

  describe "Game.winner" do
    test "it returns 'X' when X wins" do
      board = %{ 1 => "X", 2 => "X", 3 => "O", 4 => "O", 5 => "X", 6 => "X", 7 => "O", 8 => "X", 9 => "O"}

      assert "X" == Game.winner(board)
    end

    test "it returns 'O' when O wins" do
      board = %{ 1 => "X", 2 => "O", 3 => "X", 4 => "X", 5 => "X", 6 => nil, 7 => "O", 8 => "O", 9 => "O"}

      assert "O" == Game.winner(board)
    end
  end
end
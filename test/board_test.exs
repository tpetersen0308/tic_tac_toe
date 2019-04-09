defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "it can create an empty board" do 
    assert %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil } == Board.empty
  end

  test "it can update the board" do
    board = Board.empty

    assert %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => "X", 6 => nil, 7 => nil, 8 => nil, 9 => nil } == Board.update(board, 5, "X")
  end

  describe "Board.is_full" do
    board = %{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"}
    
    test "it returns true for a full board" do
      assert Board.is_full(unquote(Macro.escape(board)))
    end

    test "it returns false for a board that has at least one available position" do
      board = Board.update(unquote(Macro.escape(board)), 6, nil)
      
      assert !Board.is_full(board)
    end
  end

  test "it can return the number of turns played so far" do
    board = Board.empty
    board = Board.update(board, 5, "X") |> Board.update(8, "O") |> Board.update(2, "X")

    assert 3 == Board.turn_count(board)
  end
end
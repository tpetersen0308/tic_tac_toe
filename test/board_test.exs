defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "it can create an empty board" do 
    assert %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil } == Board.empty
  end

  describe "Board.is_full" do
    test "it returns true for a full board" do
      assert Board.is_full(%{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "X", 8 => "O", 9 => "X" })
    end

    test "it returns false for a board that has at least one available position" do
      assert !Board.is_full(%{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => nil, 7 => "X", 8 => "O", 9 => "X" })
    end
  end

  test "it can update the board" do
    board = Board.empty

    assert %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => "X", 6 => nil, 7 => nil, 8 => nil, 9 => nil } == Board.update(board, 5, "X")
  end
end
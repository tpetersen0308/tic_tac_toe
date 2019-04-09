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
end
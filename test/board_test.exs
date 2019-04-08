defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "it can create an empty board" do 
    assert %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil } == Board.empty
  end

  test "it can check for a full board" do
    assert Board.is_full(%{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "X", 8 => "O", 9 => "X" })
  end
end
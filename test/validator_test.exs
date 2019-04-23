defmodule TicTacToe.ValidatorTest do
  use ExUnit.Case
  doctest TicTacToe.Validator
  import TicTacToe.Validator

  describe "validate_move" do
    test "it returns results when a move is not an integer" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = "foo"
      
      assert validate_move(move, board) == {move, false, :nan}
    end

    test "it returns results when a move is out of board range" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 10

      assert validate_move(move, board) == {move, false, :not_available}
    end

    test "it returns results when a move is unavailable" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 3

      assert validate_move(move, board) == {move, false, :not_available}
    end

    test "it returns results when a move is valid" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 5

      assert validate_move(move, board) == {move, true, nil}   
    end
  end

  describe "valide_numeric_selection" do
    test "it returns false when a selection is not in the valid range of options" do
      options = 1..10
      selection = 11

      assert validate_numeric_selection(selection, options) == {selection, false}
    end

    test "it returns the user's selection when it is in the valid range of options" do
      options = 1..10
      selection = 8

      assert validate_numeric_selection(selection, options) == {selection, true}
    end
  end
end
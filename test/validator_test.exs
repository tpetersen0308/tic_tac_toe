defmodule TicTacToe.ValidatorTest do
  use ExUnit.Case
  doctest TicTacToe.Validator
  import TicTacToe.Validator

  describe "validate_move" do
    test "it returns results when a move is not an integer" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = "foo"
      
      assert validate_move(move, board) == {:error, move, :nan}
    end

    test "it returns results when a move is out of board range" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 10

      assert validate_move(move, board) == {:error, move, :not_available}
    end

    test "it returns results when a move is unavailable" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 3

      assert validate_move(move, board) == {:error, move, :not_available}
    end

    test "it returns results when a move is valid" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 5

      assert validate_move(move, board) == {:ok, move, nil}   
    end
  end

  describe "valide_numeric_selection" do
    test "it returns :error with the user's selection when it is not in the valid range of options" do
      options = 1..10
      selection = 11

      assert validate_numeric_selection(selection, options) == {:error, selection}
    end

    test "it returns :ok with the user's selection when it is in the valid range of options" do
      options = 1..10
      selection = 8

      assert validate_numeric_selection(selection, options) == {:ok, selection}
    end
  end
end
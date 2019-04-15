defmodule ValidatorTest do
  use ExUnit.Case
  doctest Validator
  import Validator

  @empty_board Board.empty

  describe "Validator.is_valid_move" do
    test "can determine if a move is outside the range of board positions" do
      assert !is_valid_move(@empty_board, 10)
    end

    test "can determine if a move is an integer inside the range of board positions" do
      assert is_valid_move(@empty_board, 9)
    end

    test "can determine if a move is not an integer" do
      assert !is_valid_move(@empty_board, "foo")
    end
  end

  describe "Board.is_available" do
    test "it can determine if a position is available" do
      board = %{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => nil, 7 => "O", 8 => "X", 9 => "O"}

      assert is_available_position(board, 6)
    end

    test "it can determine if a position is unavailable" do
      board = %{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"}
      
      assert !is_available_position(board, 6)
    end
  end
end
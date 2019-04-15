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
end
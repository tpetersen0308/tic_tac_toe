defmodule ValidatorTest do
  use ExUnit.Case
  doctest Validator
  import Validator
  import Mock

  describe("Validator.validate_input") do
    test "it can validate user input and recurse to get valid input" do
      with_mocks([
        {
          GameManager, 
          [],
          [
            get_move: fn(_) -> 5 end,
          ]
        },
        {
          GameIO,
          [],
          [
            print_board: fn(_) -> nil end,
            invalid_input: fn(_) -> nil end,
          ]
        }
      ]) do
        board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
        move = "foo"
        target_cell = board[move]
        
        assert validate_input(board, target_cell, move) == 5

        move = "10"
        target_cell = board[move]
        
        assert validate_input(board, target_cell, move) == 5

        move = "1"
        target_cell = board[move]
        
        assert validate_input(board, target_cell, move) == 5
      end
    end
  end
end
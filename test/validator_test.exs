defmodule ValidatorTest do
  use ExUnit.Case
  doctest Validator
  import Validator
  import Mock
  import ExUnit.CaptureIO

  describe("Validator.validate_move") do
    test "it can validate user input and recurse to get valid move selection" do
      with_mocks([
        {
          GameManager, 
          [],
          [
            move: fn(_) -> 5 end,
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
        
        assert validate_move(board, target_cell, move) == 5

        move = "10"
        target_cell = board[move]
        
        assert validate_move(board, target_cell, move) == 5

        move = "1"
        target_cell = board[move]
        
        assert validate_move(board, target_cell, move) == 5
      end
    end
  end

  describe("Validator.validate_player_selection") do
    test "it can validate user input and recurse to get valid player selection" do
      with_mocks([
        {
          GameManager, 
          [],
          [
            player_selection: fn -> 1 end,
          ]
        },
      ]) do
      capture_io(fn -> 
        assert validate_player_selection(5) == 1
      end)
      end
    end
  end
end
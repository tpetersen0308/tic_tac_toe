defmodule ValidatorTest do
  use ExUnit.Case
  doctest Validator
  import Validator
  import Mock
  import ExUnit.CaptureIO

  describe "validate_move" do
    test "it returns results when a move is not an integer" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = "foo"
      
      assert validate_move(board, move) == {move, false, "an integer"}
    end

    test "it returns results when a move is out of board range" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 10

      assert validate_move(board, move) == {move, false, "within range"}
    end

    test "it returns results when a move is unavailable" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 3

      assert validate_move(board, move) == {move, false, "available"}
    end

    test "it returns results when a move is valid" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 5

      assert validate_move(board, move) == {move, true, nil}   
    end
  end

  describe("Validator.validate_selection") do
    test "it can validate user input and recurse to get valid player selection" do
      with_mocks([
        {
          GameManager, 
          [],
          [
            player_selection: fn -> 1 end,
            game_mode_selection: fn -> 2 end,
          ]
        },
      ]) do
      capture_io(fn -> 
        assert validate_numeric_selection(5, 2, "player") == 1
        assert validate_numeric_selection(5, 2, "game mode") == 2
      end)
      end
    end
  end
end
defmodule ValidatorTest do
  use ExUnit.Case
  doctest Validator
  import Validator
  import Mock

  describe("Validator.validate_input") do
    setup_with_mocks([
      {
        GameIO, 
        [],
        [
          get_input: fn(_) -> nil end,
          invalid_input: fn(_) -> nil end,
          parse_input: fn(_) -> 5 end,
          print_board: fn(_) -> nil end,
        ]
      } 
      ]) do
        { :ok, foo: "foo"}
      end

    test "it can validate user input that is not an integer" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = "foo"
      target_cell = board[move]
      validate_input(board, target_cell, move)

      assert called GameIO.invalid_input(:_)
    end

    test "it can validate input that is not in the board range" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 10
      target_cell = board[move]
      validate_input(board, target_cell, move)

      assert called GameIO.invalid_input(:_)
    end

    test "it can validate input that corresponds to an occupied position" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 1
      target_cell = board[move]
      validate_input(board, target_cell, move)

      assert called GameIO.invalid_input(:_)
    end

    test "it gets user input again when move is invalid" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 1
      target_cell = board[move]
      assert validate_input(board, target_cell, move) == 5
    end
  end
end
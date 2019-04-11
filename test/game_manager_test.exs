defmodule GameManagerTest do
  use ExUnit.Case
  import Mock
  import GameManager
  import ExUnit.CaptureIO
  doctest GameManager

  @invalid_input_message "You entered an invalid move.\n"

  test "it can prompt the current player to make a move" do
    with_mocks([
      {
        GameIO,
        [],
        [
          get_input: fn(current_player) -> 
            IO.puts("It is #{current_player}'s turn. Please select from the available positions.")
          end,
          parse_input: fn(_) -> 5 end,
          print_board: fn(_) -> nil end,
        ]
      }
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      assert capture_io(fn -> 
        turn(board)
      end) == "It is X's turn. Please select from the available positions.\n"
    end
  end

  test "it can update the board with the player's move" do
    with_mocks([
      {
        GameIO,
        [],
        [
          get_input: fn(_) -> nil end,
          parse_input: fn(_) -> 5 end,
          print_board: fn(_) -> nil end,
        ]
      },
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      updated_board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => "X", 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      assert updated_board == turn(board)
    end
  end

  test "it can display the board" do
    with_mocks([
      {
        GameIO,
        [],
        [
          get_input: fn(_) -> nil end,
          parse_input: fn(_) -> 5 end,
          print_board: fn(_) -> IO.puts(" X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O ") end,
        ]
      }
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      assert capture_io(fn -> 
        turn(board)
      end) == " X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O \n"
    end
  end

  test "it can validate user input that is not an integer" do
    with_mocks([
     {
      GameIO, 
      [],
      [
        get_input: fn(_) -> nil end,
        parse_input: fn(_) -> 5 end,
      ]
     } 
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = "foo"
      target_cell = board[move]
      assert capture_io(fn -> 
        validate_input(board, target_cell, move)
      end) == @invalid_input_message
    end
  end

  test "it can validate input that is not in the board range" do
    with_mocks([
     {
      GameIO, 
      [],
      [
        get_input: fn(_) -> nil end,
        parse_input: fn(_) -> 5 end,
      ]
     } 
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 10
      target_cell = board[move]
      assert capture_io(fn -> 
        validate_input(board, target_cell, move)
      end) == @invalid_input_message
    end
  end

  test "it can validate input that corresponds to an occupied position" do
    with_mocks([
     {
      GameIO, 
      [],
      [
        get_input: fn(_) -> nil end,
        parse_input: fn(_) -> 5 end,
      ]
     } 
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 1
      target_cell = board[move]
      assert capture_io(fn -> 
        validate_input(board, target_cell, move)
      end) == @invalid_input_message
    end
  end

  test "it gets user input again when move is invalid" do
    with_mocks([
     {
      GameIO, 
      [],
      [
        get_input: fn(_) -> nil end,
        parse_input: fn(_) -> 5 end,
      ]
     } 
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      move = 1
      target_cell = board[move]
      assert validate_input(board, target_cell, move) == 5
    end
  end
end 
defmodule GameManagerTest do
  use ExUnit.Case
  import Mock
  import GameManager
  import ExUnit.CaptureIO
  doctest GameManager

  test "it can prompt the current player to make a move" do
    with_mocks([
      {
        GameIO,
        [],
        [
          get_input: fn(current_player) -> 
            IO.puts("It is #{current_player}'s turn. Please select from the available positions.")
          end,
          parse_input: fn(_) -> nil end,
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
          get_input: fn(_) -> 
            nil
          end,
          parse_input: fn(_) -> nil end,
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
        # parse_input: fn(_) -> 5 end,
      ]
     } 
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      assert capture_io(fn -> 
        validate_input(board, "foo")
      end) == "Invalid input.\n"
    end
  end

  test "it can validate input that is not in the board range" do
    with_mocks([
     {
      GameIO, 
      [],
      [
        get_input: fn(_) -> nil end,
        # parse_input: fn(_) -> 5 end,
      ]
     } 
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      assert capture_io(fn -> 
        validate_input(board, 10)
      end) == "Invalid input.\n"
    end
  end
end 
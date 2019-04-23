defmodule TicTacToe.GameIOTest do
  use ExUnit.Case
  doctest TicTacToe.GameIO

  import ExUnit.CaptureIO
  import TicTacToe.GameIO

  describe "print_board" do
    test "it can print the board" do
      board = %{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"}
      expected_output = "\n X | O | X \n-----------\n O | X | O \n-----------\n O | X | O \n"
      
      assert capture_io(fn -> 
        print_board(board)
      end) == expected_output
    end

    test "it can print a board of an arbitrary size" do
      board = %{1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => nil, 8 => nil, 9 => "O", 10 => nil, 11 => "X", 12 => "O", 13 => "O", 14 => nil, 15 => "X", 16 => "O"}
      expected_output = "\n X | 2 | X | O \n---------------\n X | O | 7 | 8 \n---------------\n O |10 | X | O \n---------------\n O |14 | X | O \n"

      assert capture_io(fn -> 
        print_board(board)
      end) == expected_output
    end

    test "it can print the board with the correct numbers in unoccupied positions" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"}
      expected_output = "\n X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O \n"
      
      assert capture_io(fn -> 
        print_board(board)
      end) == expected_output
    end
  end

  test "it can prompt the user for input" do
    capture_io([input: "3\n"], fn -> 
      assert get_input(:player1_turn) == 3
    end)
  end

  describe "parse_input" do
    test "it returns an integer when the user enters an integer" do
      assert parse_input("1\n") == 1
    end

    test "it returns :error when the user enters anything other than an integer" do
      assert parse_input("foo") == "foo"
    end

    test "it returns :error when the user enters an integer followed by anything other than an integer" do
      assert parse_input("1foo") == "1foo"
    end
  end
end
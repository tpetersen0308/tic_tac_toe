defmodule TicTacToe.GameIOTest do
  use ExUnit.Case
  doctest TicTacToe.GameIO

  import ExUnit.CaptureIO
  import TicTacToe.GameIO
  import Mock

  describe "print_board" do
    test "it can print the board" do
      board = %{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"}
      expected_output = "\n X | O | X \n-----------\n O | X | O \n-----------\n O | X | O \n\n"
      
      assert capture_io(fn -> 
        print_board(board)
      end) == expected_output
    end

    test "it can print a board of an arbitrary size" do
      board = %{1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => nil, 8 => nil, 9 => "O", 10 => nil, 11 => "X", 12 => "O", 13 => "O", 14 => nil, 15 => "X", 16 => "O"}
      expected_output = "\n X | 2 | X | O \n---------------\n X | O | 7 | 8 \n---------------\n O |10 | X | O \n---------------\n O |14 | X | O \n\n"

      assert capture_io(fn -> 
        print_board(board)
      end) == expected_output
    end

    test "it can print the board with the correct numbers in unoccupied positions" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"}
      expected_output = "\n X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O \n\n"
      
      assert capture_io(fn -> 
        print_board(board)
      end) == expected_output
    end
  end

  test "it can format the board for printing" do
    board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"}
    formatted_board = " X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O "

    assert formatted_board == format_board(board)
  end

  describe "format_rows" do
    test "it can format rows for printing" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"} 
      formatted_rows = [" X | 2 | X ", " O | 5 | 6 ", " O | 8 | O "]

      assert formatted_rows == format_rows(board)
    end

    test "it can format the rows for printing a board of arbitrary size" do
      board = %{1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => nil, 8 => nil, 9 => "O", 10 => nil, 11 => "X", 12 => "O", 13 => "O", 14 => nil, 15 => "X", 16 => "O"}
      formatted_rows = [" X | 2 | X | O ", " X | O | 7 | 8 ", " O |10 | X | O ", " O |14 | X | O "]

      assert formatted_rows == format_rows(board)
    end
  end

  describe "format_cells" do
    test "it can format the cells for each row" do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"}
      formatted_cells = [" X "," 2 "," X ", " O "," 5 "," 6 ", " O "," 8 "," O "]

      assert formatted_cells == format_cells(board)
    end

    test "it can handle double-digit positions" do
      board = %{1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => nil, 8 => nil, 9 => "O", 10 => nil, 11 => "X", 12 => "O", 13 => "O", 14 => nil, 15 => "X", 16 => "O"}
      formatted_cells = [" X ", " 2 ", " X ", " O ", " X ", " O ", " 7 ", " 8 ", " O ", "10 ", " X ", " O ", " O ", "14 ", " X ", " O "]

      assert formatted_cells == format_cells(board)
    end
  end

  test "it can prompt the user for input" do
    capture_io([input: "3\n"], fn -> 
      assert get_move("X") == 3
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

  describe "print_results" do
    test "it can print the game results for a draw" do
      assert capture_io(fn -> 
        print_result(false)
      end) == "Cat's Game!\n"
    end

    test "it can print the game results for the winner" do
      assert capture_io(fn -> 
        print_result("X")
      end) == "X won!\n"
    end
  end

  describe "GameIO.continue" do
    test "it can get user's decision to quit" do
      with_mock IO, [gets: fn(_) -> "q\n" end] do
        assert !continue("q")
      end
    end

    test "it can get user's decision to continue" do
      with_mock IO, [gets: fn(_) -> "a\n" end] do
        assert continue("q")
      end 
    end
  end

  test "it can get the user's player choice" do
    capture_io([input: "1\n"], fn -> 
      assert get_player_selection() == 1
    end)
  end

  test "it can get the user's game mode choice" do
    capture_io([input: "1\n"], fn -> 
      assert get_game_mode_selection() == 1
    end)
  end
end
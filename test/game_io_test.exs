defmodule GameIOTest do
  use ExUnit.Case
  doctest GameIO

  import ExUnit.CaptureIO
  import GameIO
  import Mock

  describe "GameIO.print_board" do
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

  describe "GameIO.format_rows" do
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

  describe "GameIO.format_cells" do
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

  test_with_mock "it can prompt the user for input", IO, [gets: fn(_) -> nil end] do
    GameIO.get_input("X")
    
    assert called IO.gets("It is X's turn. Please enter an available position: ")
  end

  describe "GameIO.parse_input" do
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

  test "it can print an invalid input message" do
    msg = "You entered an invalid move. Please try again."
    
    assert capture_io(fn ->
      GameIO.invalid_input(msg)
    end) == msg <> "\n"
  end

  describe "GameIO.print_results" do
    test "it can print the game results for a draw" do
      board = %{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"}
      
      assert capture_io(fn -> 
        GameIO.print_result(board)
      end) == "Cat's Game!\n"
    end

    test "it can print the game results for the winner" do
      board = %{ 1 => "X", 2 => "X", 3 => "O", 4 => "O", 5 => "X", 6 => "X", 7 => "O", 8 => "X", 9 => "O"}
      
      assert capture_io(fn -> 
        GameIO.print_result(board)
      end) == "X won!\n"
    end
  end

  describe "GameIO.continue" do
    test "it can get user's decision to quit" do
      with_mock IO, [gets: fn(_) -> "q\n" end] do
        assert !GameIO.continue("q")
      end
    end

    test "it can get user's decision to continue" do
      with_mock IO, [gets: fn(_) -> "a\n" end] do
        assert GameIO.continue("q")
      end 
    end
  end

  test "it can get the user's player choice" do
    capture_io([input: "1"], fn -> 
      assert GameIO.get_player_choice == "1"
    end)
  end
end
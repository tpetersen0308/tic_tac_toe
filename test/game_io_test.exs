defmodule GameIOTest do
  use ExUnit.Case
  doctest GameIO

  import ExUnit.CaptureIO
  import GameIO
  import Mock

  @incomplete_board %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"}

  describe "GameIO.print_board" do
    test "it can print the board" do
      assert capture_io(fn -> 
        print_board(%{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"})
      end) == "\n X | O | X \n-----------\n O | X | O \n-----------\n O | X | O \n"
    end

    test "it can print the board with the correct numbers in unoccupied positions" do
      assert capture_io(fn -> 
        print_board(@incomplete_board)
      end) == "\n X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O \n"
    end
  end

  test "it can format the board for printing" do
    formatted_board = " X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O "

    assert formatted_board == format_board(@incomplete_board)
  end

  test "it can format rows for printing" do 
    formatted_rows = [" X | 2 | X ", " O | 5 | 6 ", " O | 8 | O "]

    assert formatted_rows == format_rows(@incomplete_board)
  end

  test "it can format the cells for each row" do
    formatted_cells = [" X "," 2 "," X ", " O "," 5 "," 6 ", " O "," 8 "," O "]

    assert formatted_cells == format_cells(@incomplete_board)
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
      assert !parse_input("foo")
    end

    test "it returns :error when the user enters an integer followed by anything other than an integer" do
      assert !parse_input("1foo")
    end
  end
end
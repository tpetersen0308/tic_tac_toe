defmodule GameIOTest do
  use ExUnit.Case
  doctest GameIO

  import ExUnit.CaptureIO
  import GameIO

  describe "GameIO.print_board" do
    test "it can print the board" do
      assert capture_io(fn -> 
        print_board(%{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"})
      end) == " X | O | X \n-----------\n O | X | O \n-----------\n O | X | O \n"
    end

    test "it can print the board with the correct numbers in unoccupied positions" do
      assert capture_io(fn -> 
        print_board(%{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"})
      end) == " X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O \n"
    end
  end

  test "it can format the board for printing" do
    formatted_board = " X | 2 | X \n-----------\n O | 5 | 6 \n-----------\n O | 8 | O "

    assert formatted_board == format_board(%{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"})
  end

  test "it can format rows for printing" do 
    formatted_rows = [" X | 2 | X ", " O | 5 | 6 ", " O | 8 | O "]

    assert formatted_rows == format_rows(%{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O"})
  end
end
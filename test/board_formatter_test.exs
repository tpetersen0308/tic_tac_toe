defmodule BoardFormatterTest do
  use ExUnit.Case
  doctest TicTacToe.BoardFormatter
  
  import TicTacToe.BoardFormatter

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
end
defmodule GameIO do
  
  def print_board(board) do
    formatted_board = format_board(board)
    IO.puts(formatted_board)
  end

  def format_cells(board) do
    Enum.map(board, fn {pos, token} -> 
      value = token || pos
      " #{value} "
    end)
  end

  def format_rows(board) do
    
    format_cells(board)
     |> Enum.chunk_every(3)
     |> Enum.map(fn row -> Enum.join(row, "|") end)
  end

  def format_board(board) do
    formatted_rows = format_rows(board)
    Enum.join(formatted_rows, "\n-----------\n")
  end

  def get_input(player) do
    IO.gets("It is #{player}'s turn. Please select from the available positions.")
  end

  def parse_input(input) do
    elem(Integer.parse(input), 0)
  end
end
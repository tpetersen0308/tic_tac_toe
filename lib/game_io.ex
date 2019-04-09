defmodule GameIO do
  
  def print_board(board) do
    formatted_board = format_board(board)
    IO.puts(formatted_board)
  end

  def format_rows(board) do
    Enum.map(board, fn {pos, token} -> 
      value = token || pos
      " #{value} "
    end)
     |> Enum.chunk_every(3)
     |> Enum.map(fn row -> Enum.join(row, "|") end)
  end

  def format_board(board) do
    formatted_rows = format_rows(board)
    Enum.join(formatted_rows, "\n-----------\n")
  end
end
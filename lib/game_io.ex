defmodule GameIO do
  
  def print_board(board) do
    rows = Enum.map(board, fn {pos, token} -> 
      value = token || pos
      " #{value} "
    end)
     |> Enum.chunk_every(3)
    
    formatted_board = Enum.join(formatted_rows(rows), "\n-----------\n")

    IO.puts(formatted_board)
  end

  def formatted_rows(rows) do
    Enum.map(rows, fn row -> Enum.join(row, "|") end)
  end
end
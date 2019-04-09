defmodule GameIO do
  
  def print_board(board) do
    rows = Enum.map(board, fn {pos, token} -> 
      value = token || pos
      " #{value} "
    end)
     |> Enum.chunk_every(3)
     |> Enum.map(fn row -> Enum.join(row, "|") end)
    
    formatted_board = Enum.join(rows, "\n-----------\n")

    IO.puts(formatted_board)
  end
end
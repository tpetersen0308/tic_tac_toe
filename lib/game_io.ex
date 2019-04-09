defmodule GameIO do
  
  def print_board(board) do
    rows = Enum.map(board, fn {pos, token} -> 
      value = token || pos
      " #{value} "
    end)
     |> Enum.chunk_every(3)

    IO.puts(formatted_board(formatted_rows(rows)))
  end

  def format_rows(rows) do
    Enum.map(rows, fn row -> Enum.join(row, "|") end)
  end

  def format_board(formatted_rows) do
    Enum.join(formatted_rows, "\n-----------\n")
  end
end
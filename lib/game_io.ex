defmodule TicTacToe.GameIO do
  @messages Application.get_env(:tic_tac_toe, :messages)

  def get_input(term) do
    IO.gets(@messages.get(term))
      |> parse_input
  end

  def message(term) do
    IO.puts(@messages.get(term))
  end
  
  def print_board(board) do
    formatted_board = format_board(board)
    IO.puts("\n" <> formatted_board)
  end

  def format_cells(board) do
    Enum.map(board, fn {pos, token} -> 
      value = token || pos
      "#{value}" |> String.pad_leading(2) |> String.pad_trailing(3)
    end)
  end

  def format_rows(board) do
    row_size = trunc(:math.sqrt(map_size(board)))
    format_cells(board)
     |> Enum.chunk_every(row_size)
     |> Enum.map(fn row -> Enum.join(row, "|") end)
  end

  def format_board(board) do
    formatted_rows = format_rows(board)
    row_length = List.first(formatted_rows) |> String.length
    spacer = String.duplicate("-", row_length)
    Enum.join(formatted_rows, "\n#{spacer}\n")
  end

  def parse_input(input) do
    parsed = Integer.parse(input)
    cond do
      parsed == :error or elem(parsed, 1) !== "\n" -> String.trim(input) 
      true -> elem(parsed, 0)
    end
  end
end
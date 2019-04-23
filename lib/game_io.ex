defmodule TicTacToe.GameIO do
  @messages Application.get_env(:tic_tac_toe, :messages)
  @formatter Application.get_env(:tic_tac_toe, :formatter)

  def get_input(term) do
    IO.gets(@messages.get(term))
      |> parse_input
  end

  def message(term) do
    IO.puts(@messages.get(term))
  end
  
  def print_board(board) do
    formatted_board = @formatter.format_board(board)
    IO.puts("\n" <> formatted_board)
  end

  def parse_input(input) do
    parsed = Integer.parse(input)
    cond do
      parsed == :error or elem(parsed, 1) !== "\n" -> String.trim(input) 
      true -> elem(parsed, 0)
    end
  end
end
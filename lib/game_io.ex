defmodule TicTacToe.GameIO do
  
  def print_board(board) do
    formatted_board = format_board(board)
    IO.puts("\n" <> formatted_board <> "\n")
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

  def welcome_message() do
    IO.puts("\nWelcome to Tic Tac Toe!\n")
  end

  def get_move(player) do
    IO.gets("It is #{player}'s turn. Please enter an available position: ")
      |> parse_input
  end

  def get_numeric_selection(subj, opts) do
    header = "\nEnter a number to select a #{subj}:\n  " 
    menu = opts
      |> Enum.with_index(1)
      |> Enum.reduce("", fn ({opt, num}, acc) -> acc <> "#{num} >> #{opt}\n  " end)
    msg = header <> menu
    IO.gets(msg)
      |> parse_input
  end

  def parse_input(input) do
    parsed = Integer.parse(input)
    cond do
      parsed == :error or elem(parsed, 1) !== "\n" -> String.trim(input) 
      true -> elem(parsed, 0)
    end
  end

  def invalid_input(input, msg) do
    IO.puts("'#{input}' is not #{msg}. Please try again.")
  end

  def print_result(winner) do
    if winner, do: IO.puts("#{winner} won!"), else: IO.puts("Cat's Game!")
  end

  def continue(quit_char) do
    input = IO.gets("Enter <#{quit_char}> to quit, any other key to play again: ") 
    String.trim(input) !== quit_char
  end
end
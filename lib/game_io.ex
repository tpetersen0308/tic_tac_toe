defmodule GameIO do
  
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
  end

  def get_player_selection() do
    IO.gets("Enter a number to select a player:\n  1 >> Player 1\n  2 >> Player 2\n  ")
  end

  def get_game_mode_selection() do
    IO.gets("Enter a number to select a game mode:\n  1 >> Human vs. Human\n  2 >> Human vs. Computer\n  ")
  end

  def parse_input(input) do
    parsed = Integer.parse(input)
    cond do
      parsed == :error or elem(parsed, 1) !== "\n" -> String.trim(input) 
      true -> elem(parsed, 0)
    end
  end

  def player_selection() do
    get_player_selection |> parse_input
  end

  def game_mode_selection() do
    get_game_mode_selection() |> parse_input
  end

  def invalid_move(move, msg) do
    IO.puts("'#{move}' is not #{msg}. Please try again.")
  end

  def invalid_selection(selection, subject) do
    IO.puts("\n#{selection} is not a valid #{subject} choice. Please try again.")
  end

  def print_result(board) do
    if Game.check_draw(board), do: IO.puts("Cat's Game!"), else: IO.puts("#{Game.winner(board)} won!")
  end

  def continue(quit_char) do
    input = IO.gets("Enter <#{quit_char}> to quit, any other key to play again: ") 
    String.trim(input) !== quit_char
  end
end
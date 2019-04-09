defmodule Game do
  def turn_count(board) do
    Enum.filter(Map.values(board), &(&1)) |> Enum.count
  end

  def current_player(board) do
    if Integer.mod(turn_count(board), 2) == 0, do: "X", else: "O"
  end

  def check_win(board) do
    board[1] == board[2] and board[1] == board[3] and !!board[1] or
    board[4] == board[5] and board[4] == board[6] and board[4]
  end
end
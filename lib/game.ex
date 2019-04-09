defmodule Game do
  def turn_count(board) do
    Enum.filter(Map.values(board), &(&1)) |> Enum.count
  end

  def current_player(board) do
    if Integer.mod(turn_count(board), 2) == 0, do: "X", else: "O"
  end

  def check_win(board) do
    [{1,2,3}, {4,5,6}] |> Enum.map(fn combo ->
      {pos1, pos2, pos3} = {elem(combo, 0), elem(combo, 1), elem(combo, 2)}
      board[pos1] == board[pos2] and board[pos1] == board[pos3] and !!board[pos1]
    end) 
      |> Enum.any?(&(&1))
    # board[1] == board[2] and board[1] == board[3] and !!board[1] or
    # board[4] == board[5] and board[4] == board[6] and board[4]
  end
end
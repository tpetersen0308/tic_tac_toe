defmodule Game do
  def turn_count(board) do
    Enum.filter(Map.values(board), &(&1)) |> Enum.count
  end

  def current_player(board) do
    if Integer.mod(turn_count(board), 2) == 0, do: "X", else: "O"
  end
end
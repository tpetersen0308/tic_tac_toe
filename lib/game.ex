defmodule Game do
  def turn_count(board) do
    Enum.filter(Map.values(board), &(&1)) |> Enum.count
  end
end
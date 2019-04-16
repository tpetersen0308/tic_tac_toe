defmodule Board do
  def empty(row_size \\ 3) do
    board_size = row_size * row_size 
    Enum.reduce(1..board_size, %{}, &(Map.put_new(&2, &1, nil)))
  end

  def update(board, position, token) do
    Map.put(board, position, token)
  end

  def is_full(board) do
    Enum.all?(Map.values(board), &(&1))
  end

  def turn_count(board) do
    Enum.filter(Map.values(board), &(&1)) |> Enum.count
  end
end
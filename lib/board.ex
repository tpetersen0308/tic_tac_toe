defmodule Board do
  def empty(row_size \\ 3) do
    # %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    board = %{}
    board_size = row_size * row_size 
    Enum.reduce(1..board_size, %{}, fn n, acc -> Map.put_new(acc, n, nil) end)
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
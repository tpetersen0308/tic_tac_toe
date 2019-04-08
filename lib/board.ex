defmodule Board do
  def empty do
    %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
  end

  def is_full(board) do
    Enum.all?(Map.values(board), &(&1))
  end

  def update(board, position, token) do
    Map.put(board, position, token)
  end
end
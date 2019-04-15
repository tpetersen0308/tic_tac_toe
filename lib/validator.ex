defmodule Validator do
  def is_valid_move(board, position) do
    is_integer(position) and position in 1..Enum.count(board)
  end
end
defmodule TicTacToe.Validator do
  def validate_move(move, board) do
    cond do
      not is_integer(move) -> {move, false, :nan}
      move not in 1..map_size(board) or !!board[move] -> {move, false, :not_available}
      true -> {move, true, nil}
    end
  end

  def validate_numeric_selection(selection, range) do
    cond do
      selection not in range -> {selection, false}
      true -> {selection, true}
    end
  end
end
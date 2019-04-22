defmodule TicTacToe.Validator do
  def validate_move(board, move) do
    cond do
      not is_integer(move) -> {move, false, "an integer"}
      move not in 1..map_size(board) -> {move, false, "within range"}
      !!board[move] -> {move, false, "available"}
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
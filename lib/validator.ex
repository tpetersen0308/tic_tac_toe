defmodule TicTacToe.Validator do
  def validate_move(move, board) do
    cond do
      not is_integer(move) -> {:error, move, :nan}
      move not in 1..map_size(board) or !!board[move] -> {:error, move, :not_available}
      true -> {:ok, move, nil}
    end
  end

  def validate_numeric_selection(selection, range) do
    cond do
      selection not in range -> {:error, selection}
      true -> {:ok, selection}
    end
  end
end
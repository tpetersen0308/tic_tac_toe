defmodule Validator do
  defguard is_valid_move(board, target_cell, move) when not is_integer(move) or move not in 1..map_size(board) or target_cell != nil

  def validate_input(board, target_cell, move) when is_valid_move(board, target_cell, move) do
    GameIO.print_board(board)
    GameIO.invalid_input("You entered an invalid move. Please try again.")
    user_move = GameManager.get_move(board)

    validate_input(board, board[user_move], user_move)
  end

  def validate_input(_board, _target_cell, move) do
    move
  end
end
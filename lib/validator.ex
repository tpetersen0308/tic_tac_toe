defmodule Validator do
  defguard is_not_valid_move(board, target_cell, move) when not is_integer(move) or move not in 1..map_size(board) or target_cell != nil

  def validate_move(board, target_cell, move) when is_not_valid_move(board, target_cell, move) do
    GameIO.print_board(board)
    GameIO.invalid_input("'#{move}' is an invalid move. Please try again.")
    user_move = GameManager.move(board)

    validate_move(board, board[user_move], user_move)
  end

  def validate_move(_board, _target_cell, move) do
    move
  end

  def validate_selection(player_selection, mode) when player_selection not in [1,2] do
    GameIO.invalid_input("\n#{player_selection} is not a valid #{mode} choice. Please try again.")
    
    selection = case mode do
      "player" -> GameManager.player_selection
      "game mode" -> GameManager.game_mode_selection
    end

    validate_selection(selection, mode)
  end

  def validate_selection(player_selection, mode) do
    player_selection
  end
end
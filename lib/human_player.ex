defmodule TicTacToe.HumanPlayer do

  def move(deps, board, current_player_move, valid_move \\ false)

  def move(deps, board, current_player_move, valid_move) when not valid_move do
    { move, is_valid, invalid_input_msg } = deps.user_interface.get_input(current_player_move)
      |> deps.validator.validate_move(board)

    valid_move = cond do
      not is_valid -> 
        deps.user_interface.print_board(board)
        deps.user_interface.message(invalid_input_msg)
        is_valid
      true -> move
    end

    move(deps, board, current_player_move, valid_move)
  end

  def move(_deps, _board, _player, valid_move) do
    valid_move
  end
end
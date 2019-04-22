defmodule TicTacToe.HumanPlayer do

  def move(deps, board, player, valid_move \\ false)

  def move(deps, board, player, valid_move) when not valid_move do
    { move, is_valid, msg } = deps.user_interface.get_move(player.token)
      |> deps.validator.validate_move(board)

    valid_move = cond do
      not is_valid -> 
        deps.user_interface.print_board(board)
        deps.user_interface.invalid_move(move, msg)
        is_valid
      true -> move
    end

    move(deps, board, player, valid_move)
  end

  def move(_deps, _board, _player, valid_move) do
    valid_move
  end
end
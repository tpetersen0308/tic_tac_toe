defmodule TicTacToe.HumanPlayer do

  def move(deps, board, player, valid_move \\ false)

  def move(deps, board, player, valid_move) when not valid_move do
    current_player_turn = if player.token == "X", do: :player1_turn, else: :player2_turn
    { move, is_valid, invalid_input_msg } = deps.user_interface.get_input(current_player_turn)
      |> deps.validator.validate_move(board)

    valid_move = cond do
      not is_valid -> 
        deps.user_interface.print_board(board)
        deps.user_interface.message(invalid_input_msg)
        is_valid
      true -> move
    end

    move(deps, board, player, valid_move)
  end

  def move(_deps, _board, _player, valid_move) do
    valid_move
  end
end
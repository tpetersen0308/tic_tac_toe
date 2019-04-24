defmodule TicTacToe.HumanPlayer do
  def move(deps, board, current_player_turn) do
    validation_result = deps.user_interface.get_input(current_player_turn)
      |> deps.validator.validate_move(board)
    with {:error, _move, error_msg} <- validation_result do
      deps.user_interface.print_board(board)
      deps.user_interface.message(error_msg)
      move(deps, board, current_player_turn)
    else
      {:ok, move, _} ->
        move
    end
  end
end
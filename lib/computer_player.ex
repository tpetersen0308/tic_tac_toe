defmodule TicTacToe.ComputerPlayer do
  @ai Application.get_env(:tic_tac_toe, :ai)

  def move(deps, board, player) do
    get_ai_move(deps, board, player)
  end
  
  def get_ai_move(deps, board, player) do
    move = @ai.minimax(deps, board, player.token, player.token)
    move.position
  end
end
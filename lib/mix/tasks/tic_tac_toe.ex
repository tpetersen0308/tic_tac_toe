defmodule Mix.Tasks.TicTacToe do
  use Mix.Task
  
  @deps %{
    user_interface: GameIO,
    game_status: GameStatus,
    game_setup: Setup,
    board_manager: Board,
    validator: Validator,
    computer: ComputerPlayer,
  }
  
  def run(_) do
    GameManager.start(@deps)
  end
end
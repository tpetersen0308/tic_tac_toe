defmodule Mix.Tasks.TicTacToe do
  use Mix.Task
  
  @deps %{
    user_interface: TicTacToe.GameIO,
    game_status: TicTacToe.GameStatus,
    game_setup: TicTacToe.Setup,
    board_manager: TicTacToe.Board,
    validator: TicTacToe.Validator,
    human_player: TicTacToe.HumanPlayer,
    computer_player: TicTacToe.ComputerPlayer,
  }
  
  def run(_) do
    TicTacToe.GameManager.start(@deps)
  end
end
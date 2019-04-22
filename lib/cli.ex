defmodule TicTacToe.CLI do

  @deps %{
    user_interface: TicTacToe.GameIO,
    game_status: TicTacToe.GameStatus,
    game_setup: TicTacToe.Setup,
    board_manager: TicTacToe.Board,
    validator: TicTacToe.Validator,
    human_player: TicTacToe.HumanPlayer,
    computer_player: TicTacToe.ComputerPlayer,
  }

  def main(_args \\ []) do
    TicTacToe.GameManager.start(@deps)
  end
end
defmodule CLI do
  @deps %{
    user_interface: GameIO,
    game_status: Game,
    board_manager: Board,
    validator: Validator,
    computer: ComputerPlayer,
  }

  def main(_args \\ []) do
    GameManager.start(@deps)
  end
end
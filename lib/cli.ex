defmodule CLI do
  @deps %{
    user_interface: GameIO,
    game_status: Game,
  }

  def main(_args \\ []) do
    GameManager.start(@deps)
  end
end
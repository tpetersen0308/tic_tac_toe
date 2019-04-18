defmodule Mix.Tasks.TicTacToe do
  use Mix.Task

  @deps %{
    user_interface: GameIO,
  }
  
  def run(_) do
    GameManager.start(@deps)
  end
end
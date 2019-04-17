defmodule Mix.Tasks.TicTacToe do
  use Mix.Task

  def run(_) do
    GameManager.start
  end
end
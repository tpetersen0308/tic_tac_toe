defmodule GameManager do
  def turn(board) do
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
  end
end
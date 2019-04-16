defmodule ComputerPlayer do
  def get_random_move(board) do
      Enum.random(Board.available_positions(board))
  end
end
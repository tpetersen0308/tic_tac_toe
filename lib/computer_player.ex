defmodule ComputerPlayer do
  def get_move(board) do
      Enum.random(Board.available_positions(board))
  end
end
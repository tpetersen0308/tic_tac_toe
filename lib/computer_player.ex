defmodule ComputerPlayer do
  def get_random_move(board) do
      board |> Board.available_positions |> Enum.random
  end
end
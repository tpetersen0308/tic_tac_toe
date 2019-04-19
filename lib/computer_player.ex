defmodule ComputerPlayer do
  def turn(board_manager, board) do
      board |> board_manager.available_positions |> Enum.random
  end
end
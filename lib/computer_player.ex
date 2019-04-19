defmodule ComputerPlayer do
  def get_random_move(board_manager, board) do
      board |> board_manager.available_positions |> Enum.random
  end
end
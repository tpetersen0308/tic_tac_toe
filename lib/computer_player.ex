defmodule TicTacToe.ComputerPlayer do
  def move(board_manager, board) do
      board |> board_manager.available_positions |> Enum.random
  end
end
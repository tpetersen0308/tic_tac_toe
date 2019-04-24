defmodule TicTacToe.ComputerPlayerTest do
  use ExUnit.Case
  doctest TicTacToe.ComputerPlayer

  import TicTacToe.ComputerPlayer

  defmodule FakeBoardManager do
    def available_positions(_), do: [3,5,6,8]
  end

  test "it can select a random available move" do
    board = %{1 => "X", 2 => "O", 3 => nil, 4 => "X", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "X" }
    available_moves = [3, 5, 6, 8]
    move = move(FakeBoardManager, board)

    assert Enum.member?(available_moves, move) 
  end
end
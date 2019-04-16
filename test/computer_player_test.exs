defmodule ComputerPlayerTest do
  use ExUnit.Case
  doctest ComputerPlayer

  import ComputerPlayer

  test "it can select a random available move" do
    board = %{1 => "X", 2 => "O", 3 => nil, 4 => "X", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "X" }
    available_moves = [3, 5, 6, 8]
    move = get_move(board)

    assert Enum.member?(available_moves, move) 
  end
end
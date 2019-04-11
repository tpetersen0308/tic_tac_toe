defmodule GameManagerTest do
  use ExUnit.Case
  import Mock
  import GameManager
  import ExUnit.CaptureIO
  doctest GameManager

  test "it can prompt the current player to make a move" do
    with_mocks([
      {
        GameIO,
        [],
        [
          get_input: fn(current_player) -> 
            IO.puts("It is #{current_player}'s turn. Please select from the available positions.")
          end,
        ]
      }
    ]) do
      board = %{ 1 => "X", 2 => nil, 3 => "X", 4 => "O", 5 => nil, 6 => nil, 7 => "O", 8 => "X", 9 => "O"}
      assert capture_io(fn -> 
        turn(board)
      end) == "It is X's turn. Please select from the available positions.\n"
    end
  end
end 
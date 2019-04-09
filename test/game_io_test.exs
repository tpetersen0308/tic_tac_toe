defmodule GameIOTest do
  use ExUnit.Case
  doctest GameIO

  import ExUnit.CaptureIO
  import GameIO

  test "it can print the board" do
    assert capture_io(fn -> 
      print_board(%{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "O"})
    end) == " X | O | X \n-----------\n O | X | O \n-----------\n O | X | O \n"
  end
end
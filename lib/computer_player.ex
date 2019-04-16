defmodule ComputerPlayer do
  def get_move(board) do
    [ random | _ ] = Enum.filter(board, fn {_pos, tok} -> !tok end)
      |> Enum.take_random(1)
      
    elem(random, 0)
  end
end
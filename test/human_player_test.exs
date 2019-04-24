defmodule TicTacToe.HumanPlayerTest do
  use ExUnit.Case
  doctest TicTacToe.HumanPlayer
  import TicTacToe.HumanPlayer

  defmodule FakeIO do
    def get_input(_), do: Helpers.Stack.pop()
    def print_board(_), do: nil
    def message(_), do: nil
  end

  defmodule FakeValidator do
    def validate_move("foo", _), do: {:error, "foo", ""}
    def validate_move("10\n", _), do: {:error, "10", ""}
    def validate_move("5\n", _), do: {:error, 5, ""}
    def validate_move("6\n", _), do: {:ok, 6, nil}
  end
  
  test "move validates input and returns move when valid." do
    fake_deps = %{
      user_interface: FakeIO,
      validator: FakeValidator,
    }
    
    board = %{ 1 => "X", 2 => nil, 3 => nil, 4 => nil, 5 => "O", 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    player = %{token: "X", human: true}

    Helpers.Stack.setup(["foo", "10\n", "5\n", "6\n"])

    assert move(fake_deps, board, player) == 6

    Helpers.Stack.teardown
  end
end
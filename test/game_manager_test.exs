defmodule TicTacToe.GameManagerTest do
  use ExUnit.Case
  import TicTacToe.GameManager
  doctest TicTacToe.GameManager

  defmodule FakeIO do
    def print_board(_), do: nil
  end

  defmodule FakeBoard do
    def update(%{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }, 1, "X"), do: %{ 1 => "X", 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    def update(%{ 1 => "X", 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }, 4, "O"), do: %{ 1 => "X", 2 => nil, 3 => nil, 4 => "O", 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    def update(%{ 1 => "X", 2 => nil, 3 => nil, 4 => "O", 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }, 2, "X"), do: %{ 1 => "X", 2 => "X", 3 => nil, 4 => "O", 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    def update(%{ 1 => "X", 2 => "X", 3 => nil, 4 => "O", 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }, 5, "O"), do: %{ 1 => "X", 2 => "X", 3 => nil, 4 => "O", 5 => "O", 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    def update(%{ 1 => "X", 2 => "X", 3 => nil, 4 => "O", 5 => "O", 6 => nil, 7 => nil, 8 => nil, 9 => nil }, 3, "X"), do: %{ 1 => "X", 2 => "X", 3 => "X", 4 => "O", 5 => "O", 6 => nil, 7 => nil, 8 => nil, 9 => nil }
  end

  defmodule FakeValidator do
  end

  defmodule FakeHuman do
    def move(_,_,_), do: Helpers.Stack.pop()
  end

  defmodule FakeComputer do
  end

  defmodule FakeGame do
    def is_over(_, %{ 1 => "X", 2 => "X", 3 => "X", 4 => "O", 5 => "O", 6 => nil, 7 => nil, 8 => nil, 9 => nil}), do: true
    def is_over(_,_), do: false
  end

  describe "play" do
    test "it can execute a human vs human game loop" do
      fake_deps = %{
        game_status: FakeGame,
        board_manager: FakeBoard,
        user_interface: FakeIO,
        validator: FakeValidator,
        human_player: FakeHuman,
        computer_player: FakeComputer
      }
      
      players = {%{token: "X", human: true}, %{token: "O", human: true}}
      board = %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }

      Helpers.Stack.setup([1,4,2,5,3])

      assert play(fake_deps, board, players) == %{ 1 => "X", 2 => "X", 3 => "X", 4 => "O", 5 => "O", 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    
      Helpers.Stack.teardown
    end
  end
end 
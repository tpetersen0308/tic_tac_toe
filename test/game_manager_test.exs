defmodule TicTacToe.GameManagerTest do
  use ExUnit.Case
  import TicTacToe.GameManager
  import ExUnit.CaptureIO
  doctest TicTacToe.GameManager

  defmodule FakeIO do
    def get_move(_), do: 3
    def print_board(_), do: nil
    def game_mode_selection(), do: IO.gets("")
    def player_selection(), do: "1\n"
  end

  defmodule FakeBoard do
    def turn_count(%{ 1 => nil, 2 => "X", 3 => nil, 4 => nil, 5 => "X", 6 => "O", 7 => nil, 8 => "O", 9 => nil }), do: 4
    def turn_count(%{ 1 => nil, 2 => "X", 3 => nil, 4 => nil, 5 => "X", 6 => nil, 7 => nil, 8 => "O", 9 => nil }), do: 5
    def turn_count(_), do: 0
    def empty(), do: %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    def update(_,_,_), do: %{ 1 => "X", 2 => "X", 3 => "X", 4 => "O", 5 => "0", 6 => nil, 7 => nil, 8 => nil, 9 => nil}
  end

  defmodule FakeValidator do
    def validate_move(_,_), do: {3, true, nil}
    def validate_numeric_selection("1\n",_), do: {1, true}
    def validate_numeric_selection("2\n",_), do: {2, true}
  end

  defmodule FakeHuman do
    def move(_,_,_), do: 3
  end

  defmodule FakeComputer do
  end

  defmodule FakeGame do
    def is_over(_,_), do: true
    def current_player(_,_,_), do: %{token: "X", human: true}
  end

  defmodule FakeSetup do
    def players(_,1), do: {%{token: "X", human: true}, %{token: "O", human: true}}
    def players(_,2), do: {%{token: "X", human: true}, %{token: "O", human: false}}
  end

  test "it can execute a game loop" do
    fake_deps = %{
      user_interface: FakeIO,
      board_manager: FakeBoard,
      game_status: FakeGame,
      validator: FakeValidator,
      human_player: FakeHuman,
      computer_player: FakeComputer,  
    }

    players = {%{token: "X", human: true}, %{token: "O", human: true}}
    board = %{ 1 => "X", 2 => "X", 3 => nil, 4 => "O", 5 => "0", 6 => nil, 7 => nil, 8 => nil, 9 => nil}
    updated_board = %{ 1 => "X", 2 => "X", 3 => "X", 4 => "O", 5 => "0", 6 => nil, 7 => nil, 8 => nil, 9 => nil}
    capture_io(fn -> 
      assert updated_board == play(fake_deps, board, players)
    end)
  end
end 
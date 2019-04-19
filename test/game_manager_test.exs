defmodule GameManagerTest do
  use ExUnit.Case
  import GameManager
  import ExUnit.CaptureIO
  doctest GameManager

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

  defmodule FakeComputer do
  end

  defmodule FakeGame do
    def is_over(_), do: true
  end

  test "it can execute a game loop" do
    fake_deps = %{
      user_interface: FakeIO,
      board_manager: FakeBoard,
      game_status: FakeGame,
      validator: FakeValidator,
      computer: FakeComputer,  
    }

    players = {%{token: "X", human: true}, %{token: "O", human: true}}
    board = %{ 1 => "X", 2 => "X", 3 => nil, 4 => "O", 5 => "0", 6 => nil, 7 => nil, 8 => nil, 9 => nil}
    updated_board = %{ 1 => "X", 2 => "X", 3 => "X", 4 => "O", 5 => "0", 6 => nil, 7 => nil, 8 => nil, 9 => nil}
    capture_io(fn -> 
      assert updated_board == play(fake_deps, board, players)
    end)
  end

  describe "GameManager.setup" do
    test "it can set up a new human vs human game" do
      fake_deps = %{
        user_interface: FakeIO,
        board_manager: FakeBoard,
        validator: FakeValidator,
      }

      capture_io([input: "1\n"], fn -> 
        assert setup_game(fake_deps) == {
          %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil },
          {%{token: "X", human: true}, %{token: "O", human: true}}
        }
      end)
    end

    test "it can set up a new human vs computer game" do
      fake_deps = %{
        user_interface: FakeIO,
        board_manager: FakeBoard,
        validator: FakeValidator,
      }

      capture_io([input: "2\n"], fn -> 
        assert setup_game(fake_deps) == {
          %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil },
          {%{token: "X", human: true}, %{token: "O", human: false}}
        }
      end)
    end
  end

  describe "GameManager.current_player" do
    test "it returns player 1 when the turn count is even" do
      fake_deps = %{
        board_manager: FakeBoard
      }

      board = %{ 1 => nil, 2 => "X", 3 => nil, 4 => nil, 5 => "X", 6 => "O", 7 => nil, 8 => "O", 9 => nil }
      players = {%{token: "X", human: true}, %{token: "O", human: true}}
      {player1, _} = players
      
      assert player1 == current_player(fake_deps, board, players)
    end

    test "it returns player 2 when the turn count is odd" do
      fake_deps = %{
        board_manager: FakeBoard
      }

      board = %{ 1 => nil, 2 => "X", 3 => nil, 4 => nil, 5 => "X", 6 => nil, 7 => nil, 8 => "O", 9 => nil }
      players = {%{token: "X", human: true}, %{token: "O", human: true}}
      {_, player2} = players
      
      assert player2 == current_player(fake_deps, board, players)
    end
  end

  test "it can get the players based on the user's player choice" do
  fake_deps = %{
    user_interface: FakeIO,
    validator: FakeValidator
  }

  assert players(fake_deps, 2) == {%{token: "X", human: true}, %{token: "O", human: false}}
  end
end 
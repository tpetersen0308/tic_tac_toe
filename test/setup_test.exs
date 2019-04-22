defmodule TicTacToe.SetupTest do
  use ExUnit.Case

  import TicTacToe.Setup

  doctest TicTacToe.Setup

  defmodule FakeIO do
    def invalid_selection(_,_), do: nil
    def player_selection() do
      Helpers.Stack.pop()
    end
    def game_mode_selection() do
      Helpers.Stack.pop()
    end
  end

  defmodule FakeBoard do
    def empty(), do: %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
  end

  defmodule FakeValidator do
    def validate_numeric_selection("foo", 1..2), do: {"foo", false}
    def validate_numeric_selection(1, 1..2), do: {1, true}
    def validate_numeric_selection(2, 1..2), do: {2, true}
  end

  describe "game" do
    test "it can set up a new human vs human game" do
      fake_deps = %{
        user_interface: FakeIO,
        board_manager: FakeBoard,
        validator: FakeValidator
      }
      Helpers.Stack.setup(["foo", 1])
      
      assert game(fake_deps) == {
        %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil },
        {%{token: "X", human: true}, %{token: "O", human: true}}
      }

      Helpers.Stack.teardown
    end

    test "it can set up a new human vs computer game" do
      fake_deps = %{
        user_interface: FakeIO,
        board_manager: FakeBoard,
        validator: FakeValidator
      }
      Helpers.Stack.setup(["foo", 2, "foo", 1 ])
      
      assert game(fake_deps) == {
        %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil },
        {%{token: "X", human: true}, %{token: "O", human: false}}
      }

      Helpers.Stack.teardown
    end
  end

  describe "players" do
    test "it returns players for a human vs human game" do
      fake_deps = %{
        user_interface: FakeIO,
        validator: FakeValidator,
      }

      assert players(fake_deps, 1) == {%{token: "X", human: true}, %{token: "O", human: true}}
    end

    test "it returns players for a human vs computer game" do
      fake_deps = %{
        user_interface: FakeIO,
        validator: FakeValidator,
      }
      Helpers.Stack.setup(["foo", 1])
      
      assert players(fake_deps, 2) == {%{token: "X", human: true}, %{token: "O", human: false}}
      
      Helpers.Stack.teardown
    end
  end
end
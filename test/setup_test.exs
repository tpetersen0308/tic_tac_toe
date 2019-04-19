defmodule SetupTest do
  use ExUnit.Case

  import Setup
  doctest Setup

  defmodule FakeIO do
    def game_mode_selection(), do: 1
    def player_selection(), do: "foo"
  end

  defmodule FakeBoard do
    def empty(), do: %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
  end

  defmodule FakeValidator do
    def validate_numeric_selection("foo", 1..2), do: {1, true}
  end

  # describe "setup_game" do
  #   test "it can set up a new human vs human game" do
  #     fake_deps = %{
  #       user_interface: FakeIO,
  #       board_manager: FakeBoard,
  #     }
       
  #     assert setup_game(fake_deps) == {
  #       %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil },
  #       {%{token: "X", human: true}, %{token: "O", human: true}}
  #     }
  #   end
  # end

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

      assert players(fake_deps, 2) == {%{token: "X", human: true}, %{token: "O", human: false}}
    end
  end
end
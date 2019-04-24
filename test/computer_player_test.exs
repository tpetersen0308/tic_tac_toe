defmodule TicTacToe.ComputerPlayerTest do
  use ExUnit.Case
  doctest TicTacToe.ComputerPlayer

  import TicTacToe.ComputerPlayer

  @player1 %{token: "X"}
  @player2 %{token: "O"}
  @fake_deps %{board_manager: FakeBoardManager}

  defmodule FakeBoardManager do
    def available_positions(board) do
      Map.keys(:maps.filter fn _, v -> !v end, board)
    end
    def turn_count(board) do
      Enum.filter(Map.values(board), &(&1)) |> Enum.count
    end
    def update(board, position, token) do
      Map.put(board, position, token)
    end
  end

  describe "get_best_move" do
    test "it can select the best available move from an empty board" do
      board = %{1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    
      assert Enum.member?([1,3,7,9], get_best_move(@fake_deps, board, @player1))
    end

    test "it can select a winning move over a blocking move" do
      board = %{1 => nil, 2 => "O", 3 => "O", 4 => nil, 5 => "X", 6 => "X", 7 => "X", 8 => nil, 9 => "O" }
    
      assert get_best_move(@fake_deps, board, @player1) == 2
    end

    test "it can select a blocking move when no winning move is available" do
      board = %{1 => "X", 2 => nil, 3 => nil, 4 => "X", 5 => nil, 6 => nil, 7 => "O", 8 => nil, 9 => "O" }
    
      assert get_best_move(@fake_deps, board, @player1) == 8
    end

    test "it can select a winning move when many options are available" do
      board = %{1 => nil, 2 => nil, 3 => "O", 4 => "O", 5 => "X", 6 => nil, 7 => nil, 8 => nil, 9 => "X" }
    
      assert get_best_move(@fake_deps, board, @player1) == 9
    end

    test "it can prevent an opponent setting up for a win" do
      board = %{1 => nil, 2 => nil, 3 => nil, 4 => "O", 5 => nil, 6 => "X", 7 => nil, 8 => "X", 9 => nil }
    
      assert get_best_move(@fake_deps, board, @player2) == 9
    end

    test "it can select an immediate winning move when future wins are available" do
      board = %{1 => "X", 2 => nil, 3 => nil, 4 => nil, 5 => "X", 6 => "O", 7 => "O", 8 => nil, 9 => nil }
    
      assert get_best_move(@fake_deps, board, @player1) == 9
    end
  end
end
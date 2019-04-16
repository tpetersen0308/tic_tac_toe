defmodule GameManagerTest do
  use ExUnit.Case
  import Mock
  import GameManager
  import ExUnit.CaptureIO
  doctest GameManager

  test "it can execute a game loop" do
    with_mocks([
      {
        GameIO,
        [:passthrough],
        [
          get_input: fn(_) -> "3\n" end,
        ]
      }
    ]) do
      board = %{ 1 => "X", 2 => "X", 3 => nil, 4 => "O", 5 => "0", 6 => nil, 7 => nil, 8 => nil, 9 => nil}
      updated_board = %{ 1 => "X", 2 => "X", 3 => "X", 4 => "O", 5 => "0", 6 => nil, 7 => nil, 8 => nil, 9 => nil}
      capture_io(fn -> 
        assert updated_board == play(board)
      end)
    end
  end

  test "it updates the board with the computer's move" do
    board = %{1 => "X", 2 => "O", 3 => "O", 4 => "X", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => nil }
    expected_result = %{1 => "X", 2 => "O", 3 => "O", 4 => "X", 5 => "X", 6 => "O", 7 => "O", 8 => "X", 9 => "X" }
    actual_result = computer_turn(board)
    
    assert expected_result == actual_result
  end

  describe "GameManager.current_player" do
    test "it returns player 1 when the turn count is even" do
      board = %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
      board = Map.put(board, 5, "X") |> Map.put(8, "O") |> Map.put(2, "X") |> Map.put(6, "O")
      players = {%{token: "X", human: true}, %{token: "O", human: true}}
      {player1, _} = players
      
      assert player1 == current_player(board, players)
    end

    test "it returns player 2 when the turn count is odd" do
      board = %{ 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
      board = Map.put(board, 5, "X") |> Map.put(8, "O") |> Map.put(2, "X")
      players = {%{token: "X", human: true}, %{token: "O", human: true}}
      {_, player2} = players
      
      assert player2 == current_player(board, players)
    end
  end
end 
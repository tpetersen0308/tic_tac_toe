defmodule TicTacToe.GameTest do
  use ExUnit.Case
  doctest TicTacToe.GameStatus

  import TicTacToe.GameStatus

  defmodule FakeBoard do
    def is_full(_), do: true
    def turn_count(%{ 1 => nil, 2 => "X", 3 => nil, 4 => nil, 5 => "X", 6 => "O", 7 => nil, 8 => "O", 9 => nil }), do: 4
    def turn_count(%{ 1 => nil, 2 => "X", 3 => nil, 4 => nil, 5 => "X", 6 => nil, 7 => nil, 8 => "O", 9 => nil }), do: 3
    def turn_count(%{ 1 => "X", 2 => "X", 3 => "O", 4 => "O", 5 => "X", 6 => "X", 7 => "O", 8 => "X", 9 => "O"}), do: 9
    def turn_count(%{ 1 => "X", 2 => "X", 3 => nil, 4 => "O", 5 => "O", 6 => "O", 7 => "X", 8 => nil, 9 => nil}), do: 6
  end

  @empty_board %{
    1 => nil,
    2 => nil,
    3 => nil,
    4 => nil,
    5 => nil,
    6 => nil,
    7 => nil,
    8 => nil,
    9 => nil
  }
  
  @cats_game_board %{ 
    1 => "X", 
    2 => "O", 
    3 => "X", 
    4 => "O", 
    5 => "X", 
    6 => "O", 
    7 => "O", 
    8 => "X", 
    9 => "O"
  }

  describe "check_win" do
    test "it will not identify nil series as a win" do
      board = @empty_board

      assert !check_win(board)
    end

    Enum.each(%{
      "top row" => {1, 2, 3},
      "middle row" => {4, 5, 6},
      "bottom row" => {7, 8, 9},
      "left column" => {1, 4, 7},
      "middle column" => {2, 5, 8},
      "right column" => {3, 6, 9},
      "NW to SE diagonal" => {1, 5, 9},
      "SW to NE diagonal" => {3, 5, 7}
    }, fn {type, {pos1, pos2, pos3}} ->
        test "it can determine a #{type} win" do
          board = @empty_board
            |> Map.put(unquote(pos1), "X")
            |> Map.put(unquote(pos2), "X")
            |> Map.put(unquote(pos3), "X")

          assert check_win(board) == {unquote(pos1), unquote(pos2), unquote(pos3)}
        end 
      end
    )
  end

  test "it can return the winner's token" do
    assert winner(%{ 1 => "X", 2 => "X", 3 => "X", 4 => nil, 5 => nil, 6 => "O", 7 => nil, 8 => "O", 9 => nil }) == "X"
  end

  test "it can check for a draw" do
    assert check_draw(FakeBoard, @cats_game_board)
  end

  describe "is_over" do
    test "it can tell when the game has ended in a cats game" do
      assert is_over(FakeBoard, @cats_game_board)
    end

    test "it can tell when the game has ended in a win" do
      board = %{ 1 => "X", 2 => "X", 3 => "O", 4 => "O", 5 => "X", 6 => "X", 7 => "O", 8 => "X", 9 => "O"}

      assert is_over(FakeBoard, board)
    end
  end
end
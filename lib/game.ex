defmodule Game do
  @win_combos [
    {1, 2, 3}, 
    {4, 5, 6},
    {7, 8, 9},
    {1, 4, 7},
    {2, 5, 8},
    {3, 6, 9},
    {1, 5, 9},
    {3, 5, 7}
  ]

  def turn_count(board) do
    Enum.filter(Map.values(board), &(&1)) |> Enum.count
  end

  def current_player(board) do
    if Integer.mod(turn_count(board), 2) == 0, do: "X", else: "O"
  end

  def check_win(board) do
    @win_combos |> Enum.any?(fn combo ->
      {pos1, pos2, pos3} = {elem(combo, 0), elem(combo, 1), elem(combo, 2)}
      board[pos1] == board[pos2] and board[pos1] == board[pos3] and !!board[pos1]
    end) 
  end

  def check_draw(board) do
    Board.is_full(board) and not check_win(board)
  end
end
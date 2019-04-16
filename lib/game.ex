defmodule Game do
  @player1 "X"
  @player2 "O"
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

  def current_player(board) do
    if Integer.mod(Board.turn_count(board), 2) == 0, do: @player1, else: @player2
  end

  def check_win(board) do
    @win_combos |> Enum.any?(fn {pos1, pos2, pos3} ->
      board[pos1] == board[pos2] and board[pos1] == board[pos3] and !!board[pos1]
    end) 
  end

  def check_draw(board) do
    Board.is_full(board) and not check_win(board)
  end

  def is_over(board) do
    check_win(board) or check_draw(board)
  end

  def winner(board) do
    if current_player(board) == @player1, do: @player2, else: @player1
  end
end
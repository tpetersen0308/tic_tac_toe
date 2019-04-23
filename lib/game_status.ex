defmodule TicTacToe.GameStatus do
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

  def check_win(board) do
    case @win_combos |> Enum.find(fn {pos1, pos2, pos3} ->
      board[pos1] == board[pos2] and board[pos1] == board[pos3] and !!board[pos1]
    end) do
      {winner, _, _} -> board[winner]
      nil -> nil
    end
  end

  def check_draw(board_manager, board) do
    board_manager.is_full(board) and !check_win(board)
  end

  def is_over(board_manager, board) do
    !!check_win(board) or check_draw(board_manager, board)
  end
end
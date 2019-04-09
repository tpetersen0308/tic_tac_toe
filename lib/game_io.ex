defmodule GameIO do
  
  def print_board(board) do
    IO.puts(" #{board[1] || 1} | #{board[2] || 2} | #{board[3] || 3} \n-----------\n #{board[4] || 4} | #{board[5] || 5} | #{board[6] || 6} \n-----------\n #{board[7] || 7} | #{board[8] || 8} | #{board[9] || 9} ")
  end
end
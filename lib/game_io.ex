defmodule GameIO do
  
  def print_board(board) do
    IO.puts(" #{board[1]} | #{board[2]} | #{board[3]} \n-----------\n #{board[4]} | #{board[5]} | #{board[6]} \n-----------\n #{board[7]} | #{board[8]} | #{board[9]} ")
  end
end
defmodule GameManager do
  def turn(board) do
    GameIO.print_board(board)
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    user_move = GameIO.parse_input(user_input)

    Board.update(board, user_move, current_player)
  end

  def validate_input(board, target_cell, move) when not is_integer(move) or move not in 1..map_size(board) or target_cell != nil do
    IO.puts("Invalid input.")
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    user_move = GameIO.parse_input(user_input)
    validate_input(board, board[user_move], user_move)
  end

  def validate_input(board, target_cell, move) do
    move
  end
end
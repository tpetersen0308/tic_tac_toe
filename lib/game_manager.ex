defmodule GameManager do
  def turn(board) do
    GameIO.print_board(board)
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    user_move = GameIO.parse_input(user_input)

    valid_move = validate_input(board, board[user_move], user_move)
    Board.update(board, valid_move, current_player)
  end

  defguard is_valid_move(board, target_cell, move) when not is_integer(move) or move not in 1..map_size(board) or target_cell != nil

  def validate_input(board, target_cell, move) when is_valid_move(board, target_cell, move) do
    IO.puts("You entered an invalid move.")
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    user_move = GameIO.parse_input(user_input)
    validate_input(board, board[user_move], user_move)
  end

  def validate_input(_board, _target_cell, move) do
    move
  end
end
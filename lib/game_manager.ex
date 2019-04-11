defmodule GameManager do
  def play(board, over \\ false ) when over do
    board
  end

  def play(board, _over) do
    board = turn(board)
    play(board, Game.is_over(board))
  end

  def turn(board) do
    GameIO.print_board(board)
    user_move = get_move(board)
    valid_move = validate_input(board, board[user_move], user_move)

    Board.update(board, valid_move, Game.current_player(board))
  end

  def get_move(board) do
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    move = GameIO.parse_input(user_input)
    move
  end

  defguard is_valid_move(board, target_cell, move) when not is_integer(move) or move not in 1..map_size(board) or target_cell != nil

  def validate_input(board, target_cell, move) when is_valid_move(board, target_cell, move) do
    IO.puts("You entered an invalid move.")
    user_move = get_move(board)

    validate_input(board, board[user_move], user_move)
  end

  def validate_input(_board, _target_cell, move) do
    move
  end
end
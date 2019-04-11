defmodule GameManager do
  def turn(board) do
    GameIO.print_board(board)
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    user_move = GameIO.parse_input(user_input)

    Board.update(board, user_move, current_player)
  end
end
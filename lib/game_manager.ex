defmodule GameManager do
  def turn(board) do
    GameIO.print_board(board)
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    user_move = GameIO.parse_input(user_input)

    Board.update(board, user_move, current_player)
  end

  

  def validate_input(board, move) when not is_integer(move) or move not in 1..9 do
    IO.puts("Invalid input.")
  end
end
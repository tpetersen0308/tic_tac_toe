defmodule GameManager do

  def start(continue \\ true)

  def start(continue) when continue do
    board = Board.empty
    board = play(board)

    GameIO.print_board(board)
    GameIO.print_result(board)

    continue = GameIO.continue("q")
    start(continue)
  end

  def start(_continue) do
    IO.puts("Goodbye")
  end

  def play(board, over \\ false)

  def play(board, over) when over do
    board
  end

  def play(board, _over) do
    board = turn(board)
    play(board, Game.is_over(board))
  end

  def turn(board) do
    GameIO.print_board(board)
    user_move = get_move(board)
    valid_move = Validator.validate_input(board, board[user_move], user_move)

    Board.update(board, valid_move, Game.current_player(board))
  end

  def computer_turn(board) do
    move = ComputerPlayer.get_random_move(board)
    Board.update(board, move, Game.current_player(board))
  end

  def get_move(board) do
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    GameIO.parse_input(user_input)
  end
end
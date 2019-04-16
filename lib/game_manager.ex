defmodule GameManager do

  def start(continue \\ true)

  def start(continue) when continue do
    board = Board.empty
    players = get_players()
    board = play(board, players)

    GameIO.print_board(board)
    GameIO.print_result(board)

    continue = GameIO.continue("q")
    start(continue)
  end

  def start(_continue) do
    IO.puts("Goodbye")
  end

  def play(board, players, over \\ false)

  def play(board, _players, over) when over do
    board
  end

  def play(board, players, _over) do
    player = current_player(board, players)
    board = turn(board, player)
    play(board, players, Game.is_over(board))
  end

  def turn(board, player) do
    cond do 
      player.human -> human_turn(board, player)
      true -> computer_turn(board, player)
    end
  end

  def human_turn(board, player) do
    GameIO.print_board(board)
    user_move = get_move(board)
    valid_move = Validator.validate_input(board, board[user_move], user_move)

    Board.update(board, valid_move, player.token)
  end

  def computer_turn(board, player) do
    move = ComputerPlayer.get_random_move(board)
    Board.update(board, move, player.token)
  end

  def get_move(board) do
    current_player = Game.current_player(board)
    user_input = GameIO.get_input(current_player)
    GameIO.parse_input(user_input)
  end

  def get_players() do
    user_selection = GameIO.get_player_choice |> GameIO.parse_input
    {%{token: "X", human: user_selection == 1}, %{token: "O", human: user_selection == 2}}
  end

  def current_player(board, players) do
    {player1, player2} = players
    if Integer.mod(Board.turn_count(board), 2) == 0, do: player1, else: player2
  end
end
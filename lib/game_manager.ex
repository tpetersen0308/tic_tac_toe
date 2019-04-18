defmodule GameManager do

  def start(deps, continue \\ true)

  def start(deps, true) do
    { user_interface, game_status } = { deps.user_interface, deps.game_status} 
    setup_deps = %{
      user_interface: deps.user_interface,
      board: deps.board,
      validator: deps.validator,
    }

    user_interface.welcome_message
    {board, players} = setup(setup_deps)
    board = play(board, players)

    user_interface.print_board(board)

    winner = if game_status.check_win(board), do: winner(board, players).token
    user_interface.print_result(winner) 

    continue = user_interface.continue("q")
    start(deps, continue)
  end

  def start(_deps, _continue) do
    IO.puts("Goodbye")
  end

  def setup(deps, game_mode \\ nil, is_valid_game_mode \\ false)

  def setup(deps, game_mode, true) do
    {deps.board.empty, players(game_mode)}
  end

  def setup(deps, _game_mode, _is_valid_game_mode) do
    {user_interface, validator} = {deps.user_interface, deps.validator}

    {game_mode, is_valid} = validator.validate_numeric_selection(user_interface.game_mode_selection(), 1..2)
    
    if not is_valid, do: user_interface.invalid_selection(game_mode, "game mode")

    setup(deps, game_mode, is_valid)
  end

  def play(board, players, over \\ false)

  def play(board, _players, true) do
    board
  end

  def play(board, players, _over) do
    player = current_player(board, players)
    board = turn(board, player)
    play(board, players, Game.is_over(board))
  end

  def turn(board, player) do
    cond do 
      player.human -> 
        GameIO.print_board(board)
        human_turn(board, player)
      true -> computer_turn(board, player)
    end
  end

  def human_turn(board, player, move_is_valid \\ false)
  
  def human_turn(board, _player, true) do
    board
  end

  def human_turn(board, player, _move_is_valid) do
    user_move = GameIO.get_move(player.token)
    {user_move, is_valid, msg} = Validator.validate_move(board, user_move)

    board = cond do 
      not is_valid -> 
        GameIO.print_board(board)
        GameIO.invalid_move(user_move, msg)
        board
      true -> 
        Board.update(board, user_move, player.token)
      end
    
    human_turn(board, player, is_valid)
  end

  def computer_turn(board, player) do
    move = ComputerPlayer.get_random_move(board)
    Board.update(board, move, player.token)
  end
  
  def players(game_mode, selection \\ nil, is_valid_player \\ false)

  def players(_game_mode, selection, true) do
    {%{token: "X", human: selection == 1}, %{token: "O", human: selection == 2}}
  end

  def players(game_mode, _selection, _is_valid_player) do
    cond do
      game_mode == 1 -> {%{token: "X", human: true}, %{token: "O", human: true}}
      true -> 
        {selection, is_valid} = Validator.validate_numeric_selection(GameIO.player_selection(), 1..2)
        if not is_valid, do: GameIO.invalid_selection(selection, "player")
        players(game_mode, selection, is_valid)
    end
  end

  def current_player(board, players) do
    {player1, player2} = players
    if Integer.mod(Board.turn_count(board), 2) == 0, do: player1, else: player2
  end

  def winner(board, players) do
    {player1, player2} = players
    if current_player(board, players) == player1, do: player2, else: player1
  end
end
defmodule GameManager do

  def start(deps, continue \\ true)

  def start(deps, true) do
    { user_interface, game_status } = { deps.user_interface, deps.game_status} 
    
    setup_deps = %{
      user_interface: deps.user_interface,
      board_manager: deps.board_manager,
      validator: deps.validator,
    }

    user_interface.welcome_message

    {board, players} = setup_game(setup_deps)
    board = play(deps, board, players)

    user_interface.print_board(board)

    winner = if game_status.check_win(board), do: winner(%{board_manager: deps.board_manager}, board, players).token
    user_interface.print_result(winner) 

    continue = user_interface.continue("q")
    start(deps, continue)
  end

  def start(_deps, _continue) do
    IO.puts("Goodbye")
  end

  def setup_game(deps, game_mode \\ nil, is_valid_game_mode \\ false)

  def setup_game(deps, game_mode, true) do
    players_deps = %{
      user_interface: deps.user_interface, 
      validator: deps.validator
    }
    
    {deps.board_manager.empty, players(players_deps, game_mode)}
  end

  def setup_game(deps, _game_mode, _is_valid_game_mode) do
    {user_interface, validator} = {deps.user_interface, deps.validator}

    {game_mode, is_valid} = validator.validate_numeric_selection(user_interface.game_mode_selection(), 1..2)
    
    if not is_valid, do: user_interface.invalid_selection(game_mode, "game mode")

    setup_game(deps, game_mode, is_valid)
  end

  def play(deps, board, players, over \\ false)

  def play(_deps, board, _players, true) do
    board
  end

  def play(deps, board, players, _over) do
    turn_deps = %{
      user_interface: deps.user_interface,
      board_manager: deps.board_manager,
      validator: deps.validator,
      computer: deps.computer
    }

    player = current_player(%{board_manager: deps.board_manager}, board, players)
    board = turn(turn_deps, board, player)
    play(deps, board, players, deps.game_status.is_over(board))
  end

  def turn(deps, board, player) do
    move = cond do 
      player.human -> 
        human_turn_deps = %{
          user_interface: deps.user_interface, 
          validator: deps.validator
        }

        deps.user_interface.print_board(board)
        human_turn(human_turn_deps, board, player)
      true -> deps.computer.turn(deps.board_manager, board)
    end
    deps.board_manager.update(board, move, player.token)
  end

  def human_turn(deps, board, player, move_is_valid \\ false)
  
  def human_turn(_deps, board, _player, true) do
    board
  end

  def human_turn(deps, board, player, _move_is_valid) do
    {user_interface, validator} = {deps.user_interface, deps.validator}

    user_move = user_interface.get_move(player.token)
    {user_move, is_valid, msg} = validator.validate_move(board, user_move)

    board = cond do 
      not is_valid -> 
        user_interface.print_board(board)
        user_interface.invalid_move(user_move, msg)
        board
      true -> 
        user_move
      end
    
    human_turn(deps, board, player, is_valid)
  end
  
  def players(deps, game_mode, selection \\ nil, is_valid_player \\ false)

  def players(_deps, _game_mode, selection, true) do
    {%{token: "X", human: selection == 1}, %{token: "O", human: selection == 2}}
  end

  def players(deps, game_mode, _selection, _is_valid_player) do
    {user_interface, validator} = {deps.user_interface, deps.validator}

    cond do
      game_mode == 1 -> {%{token: "X", human: true}, %{token: "O", human: true}}
      true -> 
        {selection, is_valid} = validator.validate_numeric_selection(user_interface.player_selection(), 1..2)
        
        if not is_valid, do: user_interface.invalid_selection(selection, "player")
        players(deps, game_mode, selection, is_valid)
    end
  end

  def current_player(deps, board, players) do
    {player1, player2} = players
    if Integer.mod(deps.board_manager.turn_count(board), 2) == 0, do: player1, else: player2
  end

  def winner(deps, board, players) do
    {player1, player2} = players
    if current_player(deps, board, players) == player1, do: player2, else: player1
  end
end
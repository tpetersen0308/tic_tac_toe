defmodule GameManager do

  def start(deps, continue \\ true)

  def start(deps, true) do
    { user_interface, game_status, board_manager } = { deps.user_interface, deps.game_status, deps.board_manager} 
    
    setup_deps = %{
      user_interface: deps.user_interface,
      board_manager: deps.board_manager,
      game_setup: deps.game_setup,
      validator: deps.validator,
    }

    play_deps = Map.delete(deps, :game_setup)

    user_interface.welcome_message

    {board, players} = deps.game_setup.game(setup_deps)
    board = play(play_deps, board, players)

    user_interface.print_board(board)

    winner = game_status.check_win(board)
    user_interface.print_result(winner) 

    continue = user_interface.continue("q")
    start(deps, continue)
  end

  def start(_deps, _continue) do
    IO.puts("Goodbye")
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

    {player1 , player2} = players
    board = turn(turn_deps, board, player1)
    is_over = deps.game_status.is_over(deps.board_manager, board)
    play(deps, board, {player2, player1}, is_over)
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

  def human_turn(deps, board, player, valid_move \\ false)

  def human_turn(deps, board, player, valid_move) when not valid_move do
    {user_interface, validator} = {deps.user_interface, deps.validator}

    input = user_interface.get_move(player.token)
    {move, is_valid, msg} = validator.validate_move(board, input)

    valid_move = cond do 
      not is_valid -> 
        user_interface.print_board(board)
        user_interface.invalid_move(move, msg)
        is_valid
      true -> 
        move
    end
    
    human_turn(deps, board, player, valid_move)
  end

  def human_turn(_deps, _board, _player, valid_move) do
    valid_move
  end
end
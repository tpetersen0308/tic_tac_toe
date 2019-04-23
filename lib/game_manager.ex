defmodule TicTacToe.GameManager do

  def start(deps, continue \\ true)

  def start(deps, true) do
    { user_interface, game_status, game_setup } = { deps.user_interface, deps.game_status, deps.game_setup } 
    
    setup_deps = %{
      user_interface: deps.user_interface,
      board_manager: deps.board_manager,
      game_setup: deps.game_setup,
      validator: deps.validator,
    }

    play_deps = Map.delete(deps, :game_setup)

    user_interface.message(:welcome)

    {board, players} = game_setup.game(setup_deps)
    board = play(play_deps, board, players)

    user_interface.print_board(board)

    case game_status.check_win(board) do
      "X" -> user_interface.message(:player1_win)
      "O" -> user_interface.message(:player2_win)
      nil -> user_interface.message(:tie)
    end

    continue = user_interface.get_input(:continue) != "q"
    start(deps, continue)
  end

  def start(deps, _continue) do
    deps.user_interface.message(:quit)
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
      human_player: deps.human_player,
      computer_player: deps.computer_player
    }

    {player1 , player2} = players
    board = turn(turn_deps, board, player1)
    is_over = deps.game_status.is_over(deps.board_manager, board)
    play(deps, board, {player2, player1}, is_over)
  end

  def turn(deps, board, player) do
    move = cond do 
      player.human -> 
        human_player_deps = %{
          user_interface: deps.user_interface, 
          validator: deps.validator
        }

        deps.user_interface.print_board(board)
        deps.human_player.move(human_player_deps, board, player)
      true -> deps.computer_player.move(deps.board_manager, board)
    end
    deps.board_manager.update(board, move, player.token)
  end
end
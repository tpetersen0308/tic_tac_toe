defmodule GameManager do

  def setup(game_mode \\ nil, is_valid_game_mode \\ false)

  def setup(game_mode, is_valid_game_mode) when is_valid_game_mode do
    {Board.empty, players(game_mode)}
  end

  def setup(_game_mode, _is_valid_game_mode) do
    {game_mode, is_valid} = Validator.validate_numeric_selection(game_mode_selection(), 1..2)
    
    if not is_valid, do: GameIO.invalid_selection(game_mode, "game mode")

    setup(game_mode, is_valid)
  end

  def start(continue \\ true)

  def start(continue) when continue do
    GameIO.welcome_message
    {board, players} = setup()
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

  def human_turn(board, player, move_is_valid \\ false)
  
  def human_turn(board, _player, move_is_valid) when move_is_valid do
    board
  end

  def human_turn(board, player, _move_is_valid) do
    GameIO.print_board(board)
    user_move = move(board)
    {user_move, is_valid, msg} = Validator.validate_move(board, user_move)

    board = cond do 
      not is_valid -> 
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

  def move(board) do
    current_player = Game.current_player(board)
    user_input = GameIO.get_move(current_player)
    GameIO.parse_input(user_input)
  end

  def player_selection() do
    GameIO.get_player_selection |> GameIO.parse_input
  end

  def game_mode_selection() do
    GameIO.get_game_mode_selection() |> GameIO.parse_input
  end

  def players(game_mode, selection \\ nil, is_valid_player \\ false)

  def players(_game_mode, selection, is_valid_player) when is_valid_player do
    {%{token: "X", human: selection == 1}, %{token: "O", human: selection == 2}}
  end

  def players(game_mode, _selection, _is_valid_player) do
    cond do
      game_mode == 1 -> {%{token: "X", human: true}, %{token: "O", human: true}}
      true -> 
        {selection, is_valid} = Validator.validate_numeric_selection(player_selection(), 1..2)
        if not is_valid, do: GameIO.invalid_selection(selection, "player")
        players(game_mode, selection, is_valid)
    end
  end

  def current_player(board, players) do
    {player1, player2} = players
    if Integer.mod(Board.turn_count(board), 2) == 0, do: player1, else: player2
  end
end
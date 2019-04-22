defmodule TicTacToe.Setup do
  def game(deps, game_mode \\ nil, is_valid_game_mode \\ false)

  def game(deps, game_mode, true) do
    players_deps = %{
      user_interface: deps.user_interface, 
      validator: deps.validator
    }
    
    {deps.board_manager.empty, players(players_deps, game_mode)}
  end

  def game(deps, _game_mode, _is_valid_game_mode) do
    {user_interface, validator} = {deps.user_interface, deps.validator}

    {game_mode, is_valid} = user_interface.get_numeric_selection("game mode", ["Human vs. Human", "Human vs. Computer"])
      |> validator.validate_numeric_selection(1..2)
    
    if not is_valid, do: user_interface.invalid_input(game_mode, "a valid game mode")

    game(deps, game_mode, is_valid)
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
        {selection, is_valid} = user_interface.get_numeric_selection("player", ["Player 1", "Player 2"])
        |> validator.validate_numeric_selection(1..2)
        
        if not is_valid, do: user_interface.invalid_input(selection, "a valid player")
        players(deps, game_mode, selection, is_valid)
    end
  end
end
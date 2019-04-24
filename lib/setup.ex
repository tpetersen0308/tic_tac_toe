defmodule TicTacToe.Setup do
  @player1_token Application.get_env(:tic_tac_toe, :player1_token)
  @player2_token Application.get_env(:tic_tac_toe, :player2_token)

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

    {game_mode, is_valid} = user_interface.get_input(:game_mode)
      |> validator.validate_numeric_selection(1..2)
    
    if not is_valid, do: user_interface.message(:invalid_game_mode)

    game(deps, game_mode, is_valid)
  end

  def players(deps, game_mode) do
    with 1 <- game_mode do
      human_v_human_players()
    else 2 ->
      human_v_computer_players(deps) 
    end
  end

  defp human_v_human_players() do
    {%{token: @player1_token, human: true}, %{token: @player2_token, human: true}}
  end

  defp human_v_computer_players(deps) do
    validation_result = deps.user_interface.get_input(:player)
      |> deps.validator.validate_numeric_selection(1..2)
    with { :error, selection } <- validation_result do
      deps.user_interface.message(:invalid_player)
      human_v_computer_players(deps)
    else 
      { :ok, selection } -> 
        {%{token: @player1_token, human: selection == 1}, %{token: @player2_token, human: selection == 2}}
    end
  end
end
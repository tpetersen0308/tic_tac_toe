defmodule TicTacToe.Setup do
  @player1_token Application.get_env(:tic_tac_toe, :player1_token)
  @player2_token Application.get_env(:tic_tac_toe, :player2_token)
  @human_v_human_mode Application.get_env(:tic_tac_toe, :human_v_human_mode)
  @human_v_computer_mode Application.get_env(:tic_tac_toe, :human_v_computer_mode)
  @player1_selector Application.get_env(:tic_tac_toe, :player1_selector)
  @player2_selector Application.get_env(:tic_tac_toe, :player2_selector)
  @num_mode_options Application.get_env(:tic_tac_toe, :num_mode_options)
  @num_player_options Application.get_env(:tic_tac_toe, :num_player_options)

  def game(deps) do
    validation_result = deps.user_interface.get_input(:game_mode)
      |> deps.validator.validate_numeric_selection(@num_mode_options)
    with {:error, _game_mode_selection} <- validation_result do
      deps.user_interface.message(:invalid_game_mode)
      game(deps)
    else {:ok, game_mode_selection} ->
      {deps.board_manager.empty, players(%{user_interface: deps.user_interface, validator: deps.validator}, game_mode_selection)}
    end
  end

  def players(deps, game_mode) do
    with @human_v_human_mode <- game_mode do
      human_v_human_players()
    else @human_v_computer_mode ->
      human_v_computer_players(deps) 
    end
  end

  defp human_v_human_players() do
    {%{token: @player1_token, human: true}, %{token: @player2_token, human: true}}
  end

  defp human_v_computer_players(deps) do
    validation_result = deps.user_interface.get_input(:player)
      |> deps.validator.validate_numeric_selection(@num_player_options)
    with { :error, _player_selection } <- validation_result do
      deps.user_interface.message(:invalid_player)
      human_v_computer_players(deps)
    else 
      { :ok, player_selection } -> 
        {%{token: @player1_token, human: player_selection == @player1_selector}, %{token: @player2_token, human: player_selection == @player2_selector}}
    end
  end
end
defmodule TicTacToe.Setup do
  @player1_token Application.get_env(:tic_tac_toe, :player1_token)
  @player2_token Application.get_env(:tic_tac_toe, :player2_token)

  def game(deps) do
    validation_result = deps.user_interface.get_input(:game_mode)
      |> deps.validator.validate_numeric_selection(1..2)
    with {:error, _game_mode_selection} <- validation_result do
      deps.user_interface.message(:invalid_game_mode)
      game(deps)
    else {:ok, game_mode_selection} ->
      {deps.board_manager.empty, players(%{user_interface: deps.user_interface, validator: deps.validator}, game_mode_selection)}
    end
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
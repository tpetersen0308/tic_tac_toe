defmodule TicTacToe.Messages do
  @quit_char Application.get_env(:tic_tac_toe, :quit_char)
  @human_v_human_mode Application.get_env(:tic_tac_toe, :human_v_human_mode)
  @human_v_computer_mode Application.get_env(:tic_tac_toe, :human_v_computer_mode)
  @player1_selector Application.get_env(:tic_tac_toe, :player1_selector)
  @player2_selector Application.get_env(:tic_tac_toe, :player2_selector)

  def get(term) do
    messages = %{
      welcome: "\nWelcome to Tic Tac Toe!",
      player1_turn: "\nIt is player one's turn. Please enter an available position: ",
      player2_turn: "\nIt is player two's turn. Please enter an available position: ",
      game_mode: "\nEnter a number to select a game mode: \n  #{@human_v_human_mode} >> Human vs. Human\n  #{@human_v_computer_mode} >> Human vs. Computer\n  ",
      player: "\nEnter a number to select a player: \n  #{@player1_selector} >> Player 1\n  #{@player2_selector} >> Player 2\n  ",
      invalid_game_mode: "\nThat is not a valid game mode. Please try again.",
      invalid_player: "\nThat is not a valid player option. Please try again.",
      nan: "\nThat is not an integer. Please try again.",
      not_available: "\nThat is not an available position. Please try again.",
      player1_win: "Player one won!",
      player2_win: "Player two won!",
      tie: "Cat's game!",
      continue: "\nEnter <#{@quit_char}> to quit, any other key to play again: ",
      quit: "Goodbye!",
    }

    messages[term]
  end
end
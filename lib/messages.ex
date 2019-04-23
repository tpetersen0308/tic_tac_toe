defmodule Messages do
  def get(term) do
    messages = %{
      welcome: "\nWelcome to Tic Tac Toe!",
      player1_turn: "\nIt is player one's turn. Please enter an available position: ",
      player2_turn: "\nIt is player two's turn. Please enter an available position: ",
      game_mode: "\nEnter a number to select a game mode: \n  1 >> Human vs. Human\n  2 >> Human vs. Computer\n  ",
      player: "\nEnter a number to select a player: \n  1 >> Player 1\n  2 >> Player 2\n  ",
      invalid_game_mode: "\nThat is not a valid game mode. Please try again.",
      invalid_player: "\nThat is not a valid player option. Please try again.",
      nan: "\nThat is not an integer. Please try again.",
      not_available: "\nThat is not an available position. Please try again.",
      player1_win: "Player one won!",
      player2_win: "Player two won!",
      tie: "Cat's game!",
      continue: "\nEnter <q> to quit, any other key to play again: ",
      quit: "Goodbye!",
    }

    messages[term]
  end
end
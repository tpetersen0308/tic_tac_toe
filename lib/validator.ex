defmodule Validator do
  def validate_move(board, move) do
    cond do
      not is_integer(move) -> {move, false, "an integer"}
      move not in 1..map_size(board) -> {move, false, "within range"}
      !!board[move] -> {move, false, "available"}
      true -> {move, true, nil}
    end
  end

  def validate_numeric_selection(selection, range) do
    cond do
      selection not in range -> {selection, false}
      true -> {selection, true}
    end
  end

  # def validate_numeric_selection(selection, number_of_options, subject) when selection not in 1..number_of_options do
  #   GameIO.invalid_selection(selection, subject)
    
  #   selection = case subject do
  #     "player" -> GameManager.player_selection
  #     "game mode" -> GameManager.game_mode_selection
  #   end

  #   validate_numeric_selection(selection, number_of_options, subject)
  # end

  # def validate_numeric_selection(selection, _number_of_options, _subject) do
  #   selection
  # end
end
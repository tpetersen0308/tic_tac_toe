defmodule TicTacToe.ComputerPlayer do
  @player1_token Application.get_env(:tic_tac_toe, :player1_token)
  @player2_token Application.get_env(:tic_tac_toe, :player2_token)

  def move(deps, board, player) do
    get_ai_move(deps, board, player)
  end
  
  def get_ai_move(deps, board, player) do
    max_player = if player.token == @player1_token, do: @player1_token, else: @player2_token
    minimax(deps, board, max_player, max_player).position
  end

  def minimax(deps, board, current_player, max_player) do
    with true <- deps.game_status.is_over(deps.board_manager, board) do
      score_move(deps.game_status.winner(board), max_player, opponent(max_player))
    else false ->
      scored_moves = deps.board_manager.available_positions(board)
        |> Enum.map(fn position -> 
        next_board = deps.board_manager.update(board, position, current_player)
        next_player = opponent(current_player)
        %{position: position, score: minimax(deps, next_board, next_player, max_player).score}
      end)

      best_move(scored_moves, max_player, opponent(max_player), current_player)
    end 
  end

  defp score_move(winner, max_player, min_player) do
    case winner do
      ^max_player -> %{score: 10}
      ^min_player -> %{score: -10}
      nil -> %{score: 0}
    end    
  end

  defp best_move(scored_moves, max_player, min_player, current_player) do
    case current_player do
      ^max_player -> Enum.reduce(scored_moves, %{position: nil, score: -10}, fn (move, acc) -> if move.score >= acc.score, do: move, else: acc end)
      ^min_player -> Enum.reduce(scored_moves, %{position: nil, score: 10}, fn (move, acc) -> if move.score <= acc.score, do: move, else: acc end)
    end
  end

  defp opponent(token) do
    if token == @player1_token, do: @player2_token, else: @player1_token
  end
end
defmodule Exmon do
  alias Exmon.{Player, Game}
  alias Exmon.Game.{Actions, Status}

  @computer_name "Robotinik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]

  def create_player(name, move_rnd, move_avg, move_real) do
    Player.build(name, move_rnd, move_avg, move_real)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Game.info()
    |> Status.print_round_message()
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other_status, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    Game.info()
    |> computer_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Game.info()
    |> Status.print_round_message()
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}

    do_move(move)
  end

  defp computer_move(_), do: :ok
end

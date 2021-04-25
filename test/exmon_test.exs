defmodule ExmonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias Exmon.{Game, Player}

  describe "create_player/4" do
    test "returns a player" do
      player = Exmon.create_player("Kahue", :chute, :soco, :cura)

      expected = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Kahue"
      }

      assert player == expected
    end
  end

  describe "start_game/1" do
    test "when the gam is started, returns a message" do
      player = Player.build("Kahue", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert Exmon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Kahue", :chute, :soco, :cura)

      capture_io(fn ->
        Exmon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          Exmon.make_move(:chute)
        end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "The Computer attacked the player"
      assert messages =~ "It's player turn"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          Exmon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong"
    end

    test "when the game is over, returns a game is over message" do
      new_state = %{
        computer: %Player{
          life: 0,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Kahue"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      messages =
        capture_io(fn ->
          Exmon.make_move(:chute)
        end)

      assert messages =~ "The game is over"
    end
  end
end

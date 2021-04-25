defmodule Exmon.GameTest do
  use ExUnit.Case

  alias Exmon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Kahue", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game status" do
      player = Player.build("Kahue", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      expected = %{
        computer: %Player{
          life: 100,
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

      Game.start(computer, player)

      assert Game.info() == expected
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Kahue", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      expected = %{
        computer: %Player{
          life: 100,
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

      Game.start(computer, player)

      assert Game.info() == expected

      new_state = %{
        computer: %Player{
          life: 85,
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

      expected = %{new_state | turn: :computer, status: :continue}

      assert Game.info() == expected
    end
  end

  describe "player/0" do
    test "return the player" do
      player = Player.build("Kahue", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected = %Exmon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Kahue"
      }

      assert Game.player() == expected
    end
  end

  describe "turn/0" do
    test "return the turn" do
      player = Player.build("Kahue", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/1" do
    test "fetch the player in game" do
      player = Player.build("Kahue", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      assert Game.fetch_player(:player) == player
    end

    test "fetch the computer player in game" do
      player = Player.build("Kahue", :chute, :soco, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      assert Game.fetch_player(:computer) == computer
    end
  end
end

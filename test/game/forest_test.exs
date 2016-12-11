defmodule Game.ForestTest do
    use ExUnit.Case, async: true

    setup do
        {:ok, forest} = Game.Forest.start_link
        {:ok, forest: forest}
    end

    test "Can store Character records", %{forest: forest} do
        assert Game.Forest.get(forest, "players") == nil

        changeset = Server.Character.new_character(%Server.Character{}, %{
          name: "Player 1",
          class_id: 1,
          player_id: 1,
          id: 1
        })

        Game.Forest.put(forest, changeset.changes.name, changeset)

        playerRec = Game.Forest.get(forest, "Player 1")
        assert playerRec.changes.name == "Player 1"
        assert playerRec.changes.class_id == 1

    end

    test "Forest can store multiple characters without collisions", %{forest: forest} do
        assert Game.Forest.get(forest, "players") == nil

        changesetA = Server.Character.new_character(%Server.Character{}, %{
          name: "Tom",
          id: 8,
          class_id: 1,
          player_id: 2
        })

        changesetB = Server.Character.new_character(%Server.Character{}, %{
          name: "Dick",
          class_id: 2,
          id: 103848101,
          player_id: 3
        })

        changesetC = Server.Character.new_character(%Server.Character{}, %{
          name: "Harry",
          class_id: 3,
          player_id: 4,
          id: 10
        })

        Game.Forest.put(forest, changesetA.changes.name, changesetA)
        Game.Forest.put(forest, changesetB.changes.name, changesetB)
        Game.Forest.put(forest, changesetC.changes.name, changesetC)

        playerRec = Game.Forest.get(forest, "Tom")
        assert playerRec.changes.class_id == 1

        playerRec = Game.Forest.get(forest, "Dick")
        assert playerRec.changes.class_id == 2

        playerRec = Game.Forest.get(forest, "Harry")
        assert playerRec.changes.class_id == 3

    end

    test "can spawn new mobs into the forest", %{forest: forest} do
      assert Game.Forest.get(forest, "fights") == nil
      sesh = ")812h4g0aijdsfijqp9gh"
      id = 1
      name = "farfignuton"
      player_level = 2

      encounter = Game.Forest.spawn(forest, id, sesh, name, player_level)

      assert encounter != nil
    end

    # test "removes buckets on exit", %{forest: forest} do
    #     Game.Forest.create(registry, "Forest")
    #     {:ok, bucket} = Game.Forest.lookup(registry, "Forest")
    #     Agent.stop(bucket)
    #     assert Game.Forest.lookup(registry, "Forest") == :error
    # end
end
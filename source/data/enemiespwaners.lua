function getEnemySpawners()
return {
  ["safe_zone"] = {
    name = "safe_zone",
    battle_scene = "castle",
    chance = 1,--the chance the player has i.e (1/3)
    wait_steps = 0,--number of frames to wait to check for monster encounter
    descrption = "safe_zone",
    enemy_list = {},
    max_monsters = 0,
    min_monsters = 0

  },
  ["spawn_region_1"] = {
    name = "spawn_region_1",
    battle_scene = "castle",
    chance = 3,--the chance the player has i.e (1/3)
    wait_steps = 50,--number of frames to wait to check for monster encounter
    descrption = "first battle test",
    enemy_list = {
      {
        name = "enemy_1",
        min = 1,
        max = 3,
        chance = 1
      }
    }
  },
  ["spawn_region_2"] = {
    name = "spawn_region_2",
    battle_scene = "castle",
    chance = 1,--the chance the player has i.e (1/3)
    wait_steps = 500,--number of frames to wait to check for monster encounter
    descrption = "first battle test",
    enemy_list = {
      {
        name = "enemy_1",
        min = 1,
        max = 4,
        chance = 1
      }
    }
  }
}

end

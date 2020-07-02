--[[
This is that starting data for each class/party memeber
This will serve as an example of how to structure the data
]]
function getPartyData()
return {
  [1] = {
    name = "Default Jim",
    class = "Red Mage",
    current_level = 1,
    total_experince = 1,

    max_hp = 30,
    current_hp = 30,
    max_mp = 20,
    current_mp = 20,
    strength = 5,
    attack = 10,
    defence = 4,
    accuracy = 3,
    speed = 2,
    luck = 6,
    evasion = 5,
    intelligence = 5,
    standing_sprite = "redMage_standing" --key for the sprite

  },
  [2]= {
    name = "Default Jim",
    class = "Black Mage",
    current_level = 1,
    total_experince = 1,

    max_hp = 30,
    current_hp = 30,
    max_mp = 20,
    current_mp = 20,
    strength = 5,
    attack = 6,
    defence = 4,
    accuracy = 3,
    speed = 2,
    luck = 6,
    evasion = 5,
    standing_sprite = "redMage_standing" --key for the sprite

  }

}


end

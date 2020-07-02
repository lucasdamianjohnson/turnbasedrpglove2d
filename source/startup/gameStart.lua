function gameStart()
require("source/functions/debugdraw")
bugdraw = getDebugDraw()
-- Currently assumes 1080p resolution
love.window.setFullscreen(true)

Camera = require "source/packages/camera"
cam = Camera(0, 0,4,0,Camera.smooth.linear(0))

anim8 = require("source/packages/anim8")

local windfield = require("source/packages/windfield")
world = windfield.newWorld()
world:setQueryDebugDrawing(true)

require("source/startup/collisionClasses")
createCollisionClasses()

-- Load assets and resources

--load resources first
require("source/startup/resources")

require("source/functions/window")
window = getWindow()


require("source/player")
player = createPlayer("","")

require("source/party")
party = getParty()
party:createNewMember("Damion","Red Mage")
party:createNewMember("Dagon","Red Mage")

require("source/global")

require("source/data/rooms")
rooms = getRooms()

require("source/data/battlescenes")
battlescenes = getBattleScenes()

require("source/data/enemies")
enemies = getEnemies()

require("source/data/enemiespwaners")
enemySpawners = getEnemySpawners()



require("source/combat/combat_controller")
combat_control = getCombatController()

require("source/menus/menus")
menus = getMenus()

require("source/functions/messages")
message_controller = messageController()

--include game objects
--create game object controller
require("source/game_objects/game_object_controller")
goc =  getGameObjectController()

require("source/data/enemiespwaners")
enemy_spawners_list = getEnemySpawners()
require("source/game_objects/enemy_spawn")



--load room
require("source/loadroom")
room = loadRoom(1)
room:load()
require("source/load_battle_scene")
battles = getBattleSceneLoader()

require("source/functions/scene_transition")
screne_transitions = getScreenTransitions()


end

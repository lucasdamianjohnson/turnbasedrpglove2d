sprites = {}
sprites.redMageWalkSheet = love.graphics.newImage("source/images/players/redmage.png")


--menu sprites
sprites.menu_cursor = love.graphics.newImage("source/images/menu/pointer.png")

--battle scene assets
battle_scenes = {}
battle_scenes.castle = love.graphics.newImage("source/images/battlescenes/castle.png");

--enemy sprites
enemy_sprites = {}
enemy_sprites.skuilder = love.graphics.newImage("source/images/enemies/undead_and_magical/skuilder.png")

--items menu sprites
item_menu_sprites = {}
item_menu_sprites.potion_1 = love.graphics.newImage("source/images/menu/itemicons/potion1.png")
item_menu_sprites.cleaver = love.graphics.newImage("source/images/menu/itemicons/cleaver.png")
item_menu_sprites.sword_1 = love.graphics.newImage("source/images/menu/itemicons/sword1.png")
item_menu_sprites.sword_2 = love.graphics.newImage("source/images/menu/itemicons/sword2.png")
item_menu_sprites.staff_1 = love.graphics.newImage("source/images/menu/itemicons/staff.png")
item_menu_sprites.staff_2 = love.graphics.newImage("source/images/menu/itemicons/staff2.png")
item_menu_sprites.weapon_1 = love.graphics.newImage("source/images/menu/itemicons/weapon1.png")

--party sprites and animations
--load red mage assets
party_sprites = {}
party_sprites.redMageBattleAnimations = love.graphics.newImage("source/images/party/redmage/redmage_animations.png")
party_sprites.grids = {}
party_sprites.grids.walk = anim8.newGrid(40, 50, party_sprites.redMageBattleAnimations:getWidth(), party_sprites.redMageBattleAnimations:getHeight())

party_sprites.redMage_standing = love.graphics.newImage("source/images/party/redmage/redmagestanding.png")
party_sprites.animations = {}
party_sprites.animations.attack = anim8.newAnimation(party_sprites.grids.walk('1-2', 1), 0.175)
party_sprites.animations.walk = anim8.newAnimation(party_sprites.grids.walk('3-4', 1), 0.175)
party_sprites.animations.chargespell = anim8.newAnimation(party_sprites.grids.walk('5-6', 1), 0.175)


fonts = {}
fonts.ingamemenu =  love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 50)
fonts.items_in_itemmeu =  love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 40)
fonts.debug =  love.graphics.newFont("fonts/vt323/VT323-Regular.ttf", 25)
fonts.combat = love.graphics.newFont("fonts/combatfont/Draganaga-6YyxA.otf",60)

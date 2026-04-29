data.raw["character"]["character"].running_speed = 0.17

data.raw["mining-drill"]["burner-mining-drill"].mining_speed = 1.0 / 2.4 * 1.25
data.raw["mining-drill"]["electric-mining-drill"].mining_speed = 0.6

data.raw["construction-robot"]["construction-robot"].speed = 0.08

data.raw["inserter"]["inserter"].rotation_speed = 0.018

data.raw["pipe-to-ground"]["pipe-to-ground"].fluid_box.pipe_connections[2].max_underground_distance = 12

furnace_to_assembler("stone-furnace")
furnace_to_assembler("steel-furnace")
data.raw["furnace"]["electric-furnace"].enabled = false

local assembling_machine_1 = data.raw["assembling-machine"]["assembling-machine-1"]
table.insert(assembling_machine_1.crafting_categories, "crafting-with-fluid")
table.insert(assembling_machine_1.crafting_categories, "organic-or-assembling")
assembling_machine_1.fluid_boxes = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"].fluid_boxes)
assembling_machine_1.fluid_boxes_off_when_no_fluid_recipe = true

local agricultural_tower = data.raw["agricultural-tower"]["agricultural-tower"]
local agricultural_tower_speed = agricultural_tower.crane.speed
agricultural_tower_speed.arm.turn_rate = agricultural_tower_speed.arm.turn_rate * 0.6
agricultural_tower_speed.arm.extension_speed = agricultural_tower_speed.arm.extension_speed * 0.75
agricultural_tower_speed.grappler.vertical_turn_rate = agricultural_tower_speed.grappler.vertical_turn_rate * 0.8
agricultural_tower_speed.grappler.horizontal_turn_rate = agricultural_tower_speed.grappler.horizontal_turn_rate * 0.8
agricultural_tower_speed.grappler.extension_speed = agricultural_tower_speed.grappler.extension_speed * 0.8

local one_second = 60
local one_minute = one_second * 60
local one_hour = one_minute * 60
data.raw["capsule"]["raw-fish"].spoil_ticks = 30 * one_minute

table.insert(data.raw["lab"]["lab"]   .inputs, 1, "material-science-pack")
table.insert(data.raw["lab"]["biolab"].inputs, 1, "material-science-pack")

local gun_turret = data.raw["ammo-turret"]["gun-turret"]
gun_turret.attack_parameters.range = 24

local tank_cannon = data.raw["gun"]["tank-cannon"]
tank_cannon.attack_parameters.cooldown = 5 * one_second
tank_cannon.attack_parameters.range = 75

local cannon_shell = data.raw["ammo"]["cannon-shell"]
cannon_shell.ammo_type.action.action_delivery.max_range = 50
cannon_shell.ammo_type.action.action_delivery.direct_deviation = 0.03
cannon_shell.ammo_type.action.action_delivery.range_deviation = 0.03
local explosive_cannon_shell = data.raw["ammo"]["explosive-cannon-shell"]
explosive_cannon_shell.ammo_type.action.action_delivery.max_range = 50
explosive_cannon_shell.ammo_type.action.action_delivery.direct_deviation = 0.03
explosive_cannon_shell.ammo_type.action.action_delivery.range_deviation = 0.03

local cannon_projectile = data.raw["projectile"]["cannon-projectile"]
cannon_projectile.action.action_delivery.target_effects[1].damage.amount = 3000

for _,resource in pairs(data.raw["resource"]) do
	if resource.minable and resource.minable.mining_time then
		resource.minable.mining_time = resource.minable.mining_time * 1.25
	end
end

for _,tree in pairs(data.raw["tree"]) do
	tree.max_health = tree.max_health * 0.8
	if tree.minable then
		if tree.minable.results and tree.minable.results[1] and tree.minable.results[1].name == "wood" and tree.minable.results[1].amount then
			tree.minable.results[1].amount = tree.minable.results[1].amount * 1.5
		end
		if tree.minable.result == "wood" and tree.minable.count then
			tree.minable.count = tree.minable.count * 1.5
		end
	end
end

data.raw["cargo-wagon"]["cargo-wagon"].inventory_size = 80
data.raw["fluid-wagon"]["fluid-wagon"].inventory_size = 75000

if mods["Mini_Trains"] then
	
	local mini_locomotive = data.raw["locomotive"]["mini-locomotive"]
	mini_locomotive.max_power = "100kW"
	mini_locomotive.energy_source.effectivity = 0.5
	mini_locomotive.air_resistance = 0.0025
	mini_locomotive.friction = 0.075
	mini_locomotive.braking_force = 1
	
	local mini_fluid_wagon = data.raw["fluid-wagon"]["mini-fluid-wagon"]
	mini_fluid_wagon.air_resistance = 0.0025
	mini_fluid_wagon.friction = 0.075
	mini_fluid_wagon.braking_force = 1
	mini_fluid_wagon.capacity = 50000
	
	local mini_cargo_wagon = data.raw["cargo-wagon"]["mini-cargo-wagon"]
	mini_cargo_wagon.air_resistance = 0.0025
	mini_cargo_wagon.friction = 0.075
	mini_cargo_wagon.braking_force = 1
	mini_cargo_wagon.inventory_size = 40
	
end

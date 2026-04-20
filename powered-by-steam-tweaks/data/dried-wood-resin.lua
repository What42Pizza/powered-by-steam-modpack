local dried_wood_resin_item = {
	name = "dried-wood-resin",
	icon = "__powered-by-steam-tweaks__/graphics/icons/dried-wood-resin.png",
	order = "a[smelting]-d[wood-resin-dried]",
	stack_size = 100,
	subgroup = "raw-material",
	drop_sound = table.deepcopy(data.raw["item"]["wood"].drop_sound),
	inventory_move_sound = table.deepcopy(data.raw["item"]["wood"].inventory_move_sound),
	pick_sound = table.deepcopy(data.raw["item"]["wood"].pick_sound),
	type = "item"
}
data:extend{dried_wood_resin_item}

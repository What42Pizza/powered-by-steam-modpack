-- swap red science ingredients with material science ingredients
-- also insert red science before chem/military science ingredients
for _,tech in pairs(data.raw.technology) do
	if not tech.skip_material_science_tweaks then
		local unit = tech.unit
		if unit and unit.ingredients and #unit.ingredients > 0 then
			if unit.ingredients[1][1] == "automation-science-pack" then unit.ingredients[1][1] = "material-science-pack" end
			if #unit.ingredients > 2 then table.insert(unit.ingredients, 3, { "automation-science-pack", 1 }) end
		end
	end
end

-- swap red science prereqs with material science prereqs
for _,tech in pairs(data.raw["technology"]) do
	if tech.prerequisites then
		for i,v in ipairs(tech.prerequisites) do
			if v == "automation-science-pack" then
				tech.prerequisites[i] = "material-science-pack"
			end
		end
	end
end

-- update red science tech
local automation_science_pack_tech = data.raw["technology"]["automation-science-pack"]
automation_science_pack_tech.prerequisites = { "logistic-science-pack", "plastics" }
automation_science_pack_tech.research_trigger = nil
automation_science_pack_tech.unit = {
	count = 100,
	ingredients = {
		{ "material-science-pack", 1 },
		{ "logistic-science-pack", 1 }
	},
	time = 20
}

-- re-order science packs
data.raw["tool"]["material-science-pack"].order =        "a[material-science-pack]"
data.raw["tool"]["logistic-science-pack"].order =        "b[logistic-science-pack]"
data.raw["tool"]["automation-science-pack"].order =      "c[automation-science-pack]"
data.raw["tool"]["military-science-pack"].order =        "d[military-science-pack]"
data.raw["tool"]["chemical-science-pack"].order =        "e[chemical-science-pack]"
data.raw["tool"]["production-science-pack"].order =      "f[production-science-pack]"
data.raw["tool"]["utility-science-pack"].order =         "g[utility-science-pack]"
data.raw["tool"]["space-science-pack"].order =           "h[space-science-pack]"
data.raw["tool"]["metallurgic-science-pack"].order =     "i[metallurgic-science-pack]"
data.raw["tool"]["electromagnetic-science-pack"].order = "j[electromagnetic-science-pack]"
data.raw["tool"]["agricultural-science-pack"].order =    "k[agricultural-science-pack]"
data.raw["tool"]["cryogenic-science-pack"].order =       "l[cryogenic-science-pack]"
data.raw["tool"]["promethium-science-pack"].order =      "m[promethium-science-pack]"

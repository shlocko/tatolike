extends Node

var registry: Dictionary = {}
var registry_by_spell: Dictionary = {}

func get_upgrade(upgrade_id: int) -> Upgrade:
	return registry.get(upgrade_id)

func get_all_from_spell(spell_name: String) -> Array:
	return registry_by_spell.get(spell_name)

func _ready():
	create_general_spell_upgrades()
	create_circle_upgrades()
	create_arrow_upgrades()
	#print(get_all_from_spell("circle"))


# -------------------------
# General Spell Upgrades
# -------------------------

func create_general_spell_upgrades():
	var reg = []
	
	# -------------------------
	# Repeater (Attack Speed Multiplier Path)
	# -------------------------
	var repeater: Upgrade = Upgrade.new(
		"Repeater",
		011,
		"Increase Attack Speed by 20%.",
		30
	)
	repeater.stats_mod = func(stats: Stats) -> Stats:
		stats.attack_speed_mul += 0.2
		return stats
	registry[repeater.id] = repeater
	reg.append(repeater.id)

	var repeater_2: Upgrade = Upgrade.new(
		"Repeater II",
		012,
		"Increase Attack Speed by 10%.",
		40
	)
	repeater_2.stats_mod = func(stats: Stats) -> Stats:
		stats.attack_speed_mul += 0.1
		return stats
	repeater_2.relies_on = [011]
	registry[repeater_2.id] = repeater_2
	reg.append(repeater_2.id)

	var repeater_3: Upgrade = Upgrade.new(
		"Repeater III",
		013,
		"Increase Attack Speed by 20%.",
		60
	)
	repeater_3.stats_mod = func(stats: Stats) -> Stats:
		stats.attack_speed_mul += 0.2
		return stats
	repeater_3.relies_on = [012]
	registry[repeater_3.id] = repeater_3
	reg.append(repeater_3.id)
	
	# -------------------------
	# Sharp Edge (Damage Multiplier Path)
	# -------------------------
	var sharp_edge: Upgrade = Upgrade.new(
		"Sharp Edge",
		021,
		"Increase Damage by 20%",
		25
	)
	sharp_edge.stats_mod = func(stats: Stats) -> Stats:
		stats.damage_mul += 0.2
		return stats
	registry[sharp_edge.id] = sharp_edge
	reg.append(sharp_edge.id)

	var sharp_edge_2: Upgrade = Upgrade.new(
		"Sharp Edge II",
		022,
		"Increase Damage by 10%",
		30
	)
	sharp_edge_2.stats_mod = func(stats: Stats) -> Stats:
		stats.damage_mul += 0.1
		return stats
	sharp_edge_2.relies_on = [021]
	registry[sharp_edge_2.id] = sharp_edge_2
	reg.append(sharp_edge_2.id)

	var sharp_edge_3: Upgrade = Upgrade.new(
		"Sharp Edge III",
		023,
		"Increase Damage by 10%",
		40
	)
	sharp_edge_3.stats_mod = func(stats: Stats) -> Stats:
		stats.damage_mul += 0.1
		return stats
	sharp_edge_3.relies_on = [022]
	registry[sharp_edge_3.id] = sharp_edge_3
	reg.append(sharp_edge_3.id)

	var sharp_edge_4: Upgrade = Upgrade.new(
		"Sharp Edge IV",
		024,
		"Increase Damage by 20%",
		55
	)
	sharp_edge_4.stats_mod = func(stats: Stats) -> Stats:
		stats.damage_mul += 0.2
		return stats
	sharp_edge_4.relies_on = [023]
	registry[sharp_edge_4.id] = sharp_edge_4
	reg.append(sharp_edge_4.id)
	
	# -------------------------
	# Longshot (Range Multiplier Path)
	# -------------------------
	var longshot: Upgrade = Upgrade.new(
		"Longshot",
		031,
		"Increase Range by 20%",
		25
	)
	longshot.stats_mod = func(stats: Stats) -> Stats:
		stats.range_mul += 0.2
		return stats
	registry[longshot.id] = longshot
	reg.append(longshot.id)

	var longshot_2: Upgrade = Upgrade.new(
		"Longshot II",
		032,
		"Increase Range by 10%",
		35
	)
	longshot_2.stats_mod = func(stats: Stats) -> Stats:
		stats.range_mul += 0.1
		return stats
	longshot_2.relies_on = [031]
	registry[longshot_2.id] = longshot_2
	reg.append(longshot_2.id)

	var longshot_3: Upgrade = Upgrade.new(
		"Longshot III",
		033,
		"Increase Range by 20%",
		50
	)
	longshot_3.stats_mod = func(stats: Stats) -> Stats:
		stats.range_mul += 0.2
		return stats
	longshot_3.relies_on = [032]
	registry[longshot_3.id] = longshot_3
	reg.append(longshot_3.id)
	
	# -------------------------
	# Keen Eye (Crit Chance Additive Path)
	# -------------------------
	var keen_eye: Upgrade = Upgrade.new(
		"Keen Eye",
		041,
		"Increase Crit Chance by 10%.",
		25
	)
	keen_eye.stats_mod = func(stats: Stats) -> Stats:
		stats.crit_chance_add += 0.10
		return stats
	registry[keen_eye.id] = keen_eye
	reg.append(keen_eye.id)

	var keen_eye_2: Upgrade = Upgrade.new(
		"Keen Eye II",
		042,
		"Increase Crit Chance by 5%.",
		30
	)
	keen_eye_2.stats_mod = func(stats: Stats) -> Stats:
		stats.crit_chance_add += 0.05
		return stats
	keen_eye_2.relies_on = [041]
	registry[keen_eye_2.id] = keen_eye_2
	reg.append(keen_eye_2.id)

	var keen_eye_3: Upgrade = Upgrade.new(
		"Keen Eye III",
		043,
		"Increase Crit Chance by 15%.",
		45
	)
	keen_eye_3.stats_mod = func(stats: Stats) -> Stats:
		stats.crit_chance_add += 0.15
		return stats
	keen_eye_3.relies_on = [042]
	registry[keen_eye_3.id] = keen_eye_3
	reg.append(keen_eye_3.id)
	
	# -------------------------
	# Hypervelocity (Projectile Speed Multiplier Path)
	# -------------------------
	var hypervelocity: Upgrade = Upgrade.new(
		"Hypervelocity",
		051,
		"Increase Projectile Speed by 20%.",
		25
	)
	hypervelocity.stats_mod = func(stats: Stats) -> Stats:
		stats.projectile_speed_mul += 0.2
		return stats
	registry[hypervelocity.id] = hypervelocity
	reg.append(hypervelocity.id)

	var hypervelocity_2: Upgrade = Upgrade.new(
		"Hypervelocity II",
		052,
		"Increase Projectile Speed by 25%.",
		40
	)
	hypervelocity_2.stats_mod = func(stats: Stats) -> Stats:
		stats.projectile_speed_mul += 0.25
		return stats
	hypervelocity_2.relies_on = [051]
	registry[hypervelocity_2.id] = hypervelocity_2
	reg.append(hypervelocity_2.id)

	var hypervelocity_3: Upgrade = Upgrade.new(
		"Hypervelocity III",
		053,
		"Increase Projectile Speed by 35%.",
		60
	)
	hypervelocity_3.stats_mod = func(stats: Stats) -> Stats:
		stats.projectile_speed_mul += 0.35
		return stats
	hypervelocity_3.relies_on = [052]
	registry[hypervelocity_3.id] = hypervelocity_3
	reg.append(hypervelocity_3.id)
	
	registry_by_spell["general"] = reg
	


# -------------------------
# Circle Upgrades
# -------------------------

func create_circle_upgrades():
	var reg = []
	
	registry_by_spell["circle"] = reg

func create_arrow_upgrades():
	var reg = []
	
	registry_by_spell["arrow"] = reg

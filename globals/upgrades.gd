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
		10
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
		20
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
		50
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
		15
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
		25
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
		75
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
		10
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
		25
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
		65
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
		10
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
		25
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
		55
	)
	keen_eye_3.stats_mod = func(stats: Stats) -> Stats:
		stats.crit_chance_add += 0.15
		return stats
	keen_eye_3.relies_on = [042]
	registry[keen_eye_3.id] = keen_eye_3
	reg.append(keen_eye_3.id)
	
	var keen_eye_4: Upgrade = Upgrade.new(
		"Keen Eye IV",
		044,
		"Increase Crit Chance by 25%.",
		85
	)
	keen_eye_4.stats_mod = func(stats: Stats) -> Stats:
		stats.crit_chance_add += 0.25
		return stats
	keen_eye_4.relies_on = [043]
	registry[keen_eye_4.id] = keen_eye_4
	reg.append(keen_eye_4.id)
	
	# -------------------------
	# Hypervelocity (Projectile Speed Multiplier Path)
	# -------------------------
	var hypervelocity: Upgrade = Upgrade.new(
		"Hypervelocity",
		051,
		"Increase Projectile Speed by 20%.",
		10
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
		25
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
	
	
	# -------------------------
	# Piercing Shot (Piercing Add Upgrade Path)
	# -------------------------

	var piercing_shot: Upgrade = Upgrade.new(
		"Piercing Shot",
		101,
		"Allows projectile to pierce enemies",
		20
	)
	piercing_shot.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 1
		return stats
	piercing_shot.incompatible = [111]
	registry[piercing_shot.id] = piercing_shot
	reg.append(piercing_shot.id)

	var piercing_shot_2: Upgrade = Upgrade.new(
		"Piercing Shot II",
		102,
		"Increases pierce by 1",
		45
	)
	piercing_shot_2.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 1
		return stats
	piercing_shot_2.relies_on = [101]
	piercing_shot_2.incompatible = [111]
	registry[piercing_shot_2.id] = piercing_shot_2
	reg.append(piercing_shot_2.id)

	var piercing_shot_3: Upgrade = Upgrade.new(
		"Piercing Shot III",
		103,
		"Increases pierce by 1",
		60
	)
	piercing_shot_3.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 1
		return stats
	piercing_shot_3.relies_on = [102]
	piercing_shot_3.incompatible = [111]
	registry[piercing_shot_3.id] = piercing_shot_3
	reg.append(piercing_shot_3.id)

	var piercing_shot_4: Upgrade = Upgrade.new(
		"Piercing Shot IV",
		104,
		"Increases pierce by 2",
		95
	)
	piercing_shot_4.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 2
		return stats
	piercing_shot_4.relies_on = [103]
	piercing_shot_4.incompatible = [111]
	registry[piercing_shot_4.id] = piercing_shot_4
	reg.append(piercing_shot_4.id)
	
	
	# -------------------------
	# Explosive Shot (Explosive Upgrade Path)
	# -------------------------
	var explosive_shot: Upgrade = Upgrade.new(
		"Explosive Shot",
		111,
		"Causes projectile to explode on contact",
		25
	)
	explosive_shot.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.explosive	= true
		return stats
	explosive_shot.incompatible = [101, 131]
	registry[explosive_shot.id] = explosive_shot
	reg.append(explosive_shot.id)
	
	var explosive_shot_2: Upgrade = Upgrade.new(
		"Explosive Shot II",
		112,
		"Increase explosion radius by 50%, and explosion damage by 20%",
		50
	)
	explosive_shot_2.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.explosion_mod_add += 0.2
		stats.explosion_radius_mul += 0.5
		return stats
	explosive_shot_2.incompatible = [101]
	explosive_shot_2.relies_on = [111]
	registry[explosive_shot_2.id] = explosive_shot_2
	reg.append(explosive_shot_2.id)
	

	# -------------------------
	# Overclocked (High-Speed, Low-Damage Path)
	# -------------------------
	var overclocked: Upgrade = Upgrade.new(
		"Overclocked",
		121,
		"Increase Attack Speed by 15% but reduce Damage by 10%",
		15
	)
	overclocked.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_mul += 0.15
		stats.damage_mul -= 0.1
		return stats
	registry[overclocked.id] = overclocked
	reg.append(overclocked.id)

	var overclocked_2: Upgrade = Upgrade.new(
		"Overclocked II",
		122,
		"Increase Attack Speed by 20% but reduce Damage by 10%",
		35
	)
	overclocked_2.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_mul += 0.2
		stats.damage_mul -= 0.1
		return stats
	overclocked_2.relies_on = [121]
	registry[overclocked_2.id] = overclocked_2
	reg.append(overclocked_2.id)

	var overclocked_3: Upgrade = Upgrade.new(
		"Overclocked III",
		123,
		"Increase Attack Speed by 25% but reduce Damage by 15%",
		65
	)
	overclocked_3.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_mul += 0.25
		stats.damage_mul -= 0.15
		return stats
	overclocked_3.relies_on = [122]
	registry[overclocked_3.id] = overclocked_3
	reg.append(overclocked_3.id)

	var overclocked_4: Upgrade = Upgrade.new(
		"Overclocked IV",
		124,
		"Increase Attack Speed by 20% but reduce Crit Chance by 10%",
		95
	)
	overclocked_4.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_mul += 0.2
		stats.crit_chance_add -= 0.1
		return stats
	overclocked_4.relies_on = [123]
	registry[overclocked_4.id] = overclocked_4
	reg.append(overclocked_4.id)

	var overclocked_5: Upgrade = Upgrade.new(
		"Overclocked V",
		125,
		"Increase Attack Speed by 30% but reduce Crit Chance by 15%",
		120
	)
	overclocked_5.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_mul += 0.3
		stats.crit_chance_add -= 0.15
		return stats
	overclocked_5.relies_on = [124]
	registry[overclocked_5.id] = overclocked_5
	reg.append(overclocked_5.id)
	
	# -------------------------
	# Precision Matrix (Crit / Range / Pierce Path with Tradeoffs)
	# -------------------------
	var precision_matrix: Upgrade = Upgrade.new(
		"Precision Matrix",
		131,
		"Increase Crit Chance by 20%",
		15
	)
	precision_matrix.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.crit_chance_add += 0.2
		return stats
	precision_matrix.incompatible = [111]
	registry[precision_matrix.id] = precision_matrix
	reg.append(precision_matrix.id)

	var precision_matrix_2: Upgrade = Upgrade.new(
		"Precision Matrix II",
		132,
		"Increase Projectile Speed by 40%, Crit Damage by 50%, and reduce Attack Speed by 10%",
		35
	)
	precision_matrix_2.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.projectile_speed_mul += 0.4
		stats.crit_mod_mul += 0.5
		stats.attack_speed_mul -= 0.1
		return stats
	precision_matrix_2.relies_on = [131]
	precision_matrix_2.incompatible = [111]
	registry[precision_matrix_2.id] = precision_matrix_2
	reg.append(precision_matrix_2.id)

	var precision_matrix_3: Upgrade = Upgrade.new(
		"Precision Matrix III",
		133,
		"Increase Range by 100",
		60
	)
	precision_matrix_3.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.range_add += 100
		return stats
	precision_matrix_3.relies_on = [132]
	precision_matrix_3.incompatible = [111]
	registry[precision_matrix_3.id] = precision_matrix_3
	reg.append(precision_matrix_3.id)

	var precision_matrix_4: Upgrade = Upgrade.new(
		"Precision Matrix IV",
		134,
		"Reduce Damage by 10% and Attack Speed by 30%",
		75
	)
	precision_matrix_4.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.damage_mul -= 0.1
		stats.attack_speed_mul -= 0.3
		return stats
	precision_matrix_4.relies_on = [133]
	precision_matrix_4.incompatible = [111]
	registry[precision_matrix_4.id] = precision_matrix_4
	reg.append(precision_matrix_4.id)

	var precision_matrix_5: Upgrade = Upgrade.new(
		"Precision Matrix V",
		135,
		"Projectiles pierce infinitely",
		120
	)
	precision_matrix_5.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 999
		return stats
	precision_matrix_5.relies_on = [134]
	precision_matrix_5.incompatible = [111]
	registry[precision_matrix_5.id] = precision_matrix_5
	reg.append(precision_matrix_5.id)
	
	# -------------------------
	# Core Collapse (Power vs. Penetration Tradeoff)
	# -------------------------
	var core_collapse: Upgrade = Upgrade.new(
		"Core Collapse",
		301,
		"Increase damage by 25%, but piercing damage degrades 4% more",
		15
	)
	core_collapse.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.damage_mul += 0.25
		stats.pierce_degradation_add += 0.04
		return stats
	registry[core_collapse.id] = core_collapse
	reg.append(core_collapse.id)

	var core_collapse_2: Upgrade = Upgrade.new(
		"Core Collapse II",
		302,
		"Increase damage by 15%, but piercing damage degrades 1% more",
		35
	)
	core_collapse_2.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.damage_mul += 0.15
		stats.pierce_degradation_add += 0.01
		return stats
	core_collapse_2.relies_on = [301]
	registry[core_collapse_2.id] = core_collapse_2
	reg.append(core_collapse_2.id)

	var core_collapse_3: Upgrade = Upgrade.new(
		"Core Collapse III",
		303,
		"Increase damage by 15%, but piercing damage degrades 1% more",
		60
	)
	core_collapse_3.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.damage_mul += 0.15
		stats.pierce_degradation_add += 0.01
		return stats
	core_collapse_3.relies_on = [302]
	registry[core_collapse_3.id] = core_collapse_3
	reg.append(core_collapse_3.id)

	var core_collapse_4: Upgrade = Upgrade.new(
		"Core Collapse IV",
		304,
		"Increase damage by 30%, but piercing damage degrades 1% more",
		95
	)
	core_collapse_4.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.damage_mul += 0.3
		stats.pierce_degradation_add += 0.01
		return stats
	core_collapse_4.relies_on = [303]
	registry[core_collapse_4.id] = core_collapse_4
	reg.append(core_collapse_4.id)
	
	var core_collapse_5: Upgrade = Upgrade.new(
		"Core Collapse V",
		305,
		"Increase damage by 50%, but piercing damage degrades 3% more",
		130
	)
	core_collapse_5.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.damage_mul += 0.5
		stats.pierce_degradation_add += 0.03
		return stats
	core_collapse_5.relies_on = [303]
	registry[core_collapse_5.id] = core_collapse_5
	reg.append(core_collapse_5.id)
	
	
	registry_by_spell["circle"] = reg


	# -------------------------
	# Arrow Upgrades
	# -------------------------

func create_arrow_upgrades():
	var reg = []
	
	# -------------------------
	# Layerbreaker (Piercing Path)
	# -------------------------
	var layerbreaker: Upgrade = Upgrade.new(
		"Layerbreaker",
		201,
		"Increase piercing by 2",
		20
	)
	layerbreaker.stats_mod = func(stats: ArrowStats) -> ArrowStats:
		stats.pierce_add += 2
		return stats
	registry[layerbreaker.id] = layerbreaker
	reg.append(layerbreaker.id)

	var layerbreaker_2: Upgrade = Upgrade.new(
		"Layerbreaker II",
		202,
		"Increase piercing by 1",
		45
	)
	layerbreaker_2.stats_mod = func(stats: ArrowStats) -> ArrowStats:
		stats.pierce_add += 1
		return stats
	layerbreaker_2.relies_on = [201]
	registry[layerbreaker_2.id] = layerbreaker_2
	reg.append(layerbreaker_2.id)

	var layerbreaker_3: Upgrade = Upgrade.new(
		"Layerbreaker III",
		203,
		"Increase piercing by 2",
		65
	)
	layerbreaker_3.stats_mod = func(stats: ArrowStats) -> ArrowStats:
		stats.pierce_add += 2
		return stats
	layerbreaker_3.relies_on = [202]
	registry[layerbreaker_3.id] = layerbreaker_3
	reg.append(layerbreaker_3.id)

	var layerbreaker_4: Upgrade = Upgrade.new(
		"Layerbreaker IV",
		204,
		"Increase piercing by 3",
		95
	)
	layerbreaker_4.stats_mod = func(stats: ArrowStats) -> ArrowStats:
		stats.pierce_add += 3
		return stats
	layerbreaker_4.relies_on = [203]
	registry[layerbreaker_4.id] = layerbreaker_4
	reg.append(layerbreaker_4.id)	
	
	
	
	
	registry_by_spell["arrow"] = reg

extends Node

var registry: Dictionary = {}

func get_upgrade(spell_name: String, upgrade_id: int) -> Upgrade:
	return registry.get(spell_name).get(upgrade_id)

func get_all_from_spell(spell_name: String) -> Dictionary:
	return registry.get(spell_name)

func _ready():
	create_circle_upgrades()
	#print(get_all_from_spell("circle"))

func create_circle_upgrades():
	var upgrades := {}
	# -------------------------------
	# Demolitionist Path (Explosions)
	# -------------------------------
	var combustion_core: Upgrade = Upgrade.new("Combustion Core", 100, "Enables explosions for Circle.", 25)
	combustion_core.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.explosive = true
		return stats
	upgrades[combustion_core.id] = combustion_core

	var explosive_growth: Upgrade = Upgrade.new("Explosive Growth", 101, "Explosion radius increased by 30%.", 40)
	explosive_growth.relies_on = [100]
	explosive_growth.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.explosion_radius_mul += 0.3
		return stats
	upgrades[explosive_growth.id] = explosive_growth

	var boom_core: Upgrade = Upgrade.new("Boom Core", 102, "Explosion damage increased by +0.2.", 45)
	boom_core.relies_on = [100]
	boom_core.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.explosion_mod_add += 0.2
		return stats
	upgrades[boom_core.id] = boom_core

	var crater_maker: Upgrade = Upgrade.new("Crater Maker", 103, "Explosion radius increased by 40.", 50)
	crater_maker.relies_on = [100]
	crater_maker.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.explosion_radius_add += 40
		return stats
	upgrades[crater_maker.id] = crater_maker

	var combustive_charge: Upgrade = Upgrade.new("Combustive Charge", 104, "Explosion damage increased by 25%.", 70)
	combustive_charge.relies_on = [100, 101]
	combustive_charge.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.explosion_mod_mul += 0.25
		return stats
	upgrades[combustive_charge.id] = combustive_charge

	var heavy_circle: Upgrade = Upgrade.new("Heavy Circle", 105, "Increases your damage by 50.", 60)
	heavy_circle.relies_on = [100]
	heavy_circle.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.damage_add += 50
		return stats
	upgrades[heavy_circle.id] = heavy_circle

	# -------------------------------
	# Rapid Caster Path
	# -------------------------------

	var speed_slinger: Upgrade = Upgrade.new("Speed Slinger", 200, "Attack speed improved by 10%.", 15)
	speed_slinger.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_mul += 0.1
		return stats
	upgrades[speed_slinger.id] = speed_slinger

	var quicksilver_core: Upgrade = Upgrade.new("Quicksilver Core", 201, "Projectile speed increased by 150.", 20)
	quicksilver_core.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.projectile_speed_add += 150
		return stats
	upgrades[quicksilver_core.id] = quicksilver_core

	var overclocked_casting: Upgrade = Upgrade.new("Overclocked Casting", 202, "Boosts attack speed but reduces damage.", 30)
	overclocked_casting.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_mul += 0.3
		stats.damage_mul -= 0.15
		return stats
	upgrades[overclocked_casting.id] = overclocked_casting

	var snapfire_coil: Upgrade = Upgrade.new("Snapfire Coil", 203, "Attack speed increased by 0.1.", 50)
	snapfire_coil.relies_on = [202]
	snapfire_coil.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_add += 0.1
		return stats
	upgrades[snapfire_coil.id] = snapfire_coil

	var velocity_matrix: Upgrade = Upgrade.new("Velocity Matrix", 204, "Projectile speed increased by 25%.", 60)
	velocity_matrix.relies_on = [202]
	velocity_matrix.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.projectile_speed_mul += 0.25
		return stats
	upgrades[velocity_matrix.id] = velocity_matrix

	# -------------------------------
	# Precision Path
	# -------------------------------

	var sharpened_circles: Upgrade = Upgrade.new("Sharpened Circles", 300, "Crit chance increased by 10%.", 20)
	sharpened_circles.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.crit_chance_add += 0.1
		return stats
	upgrades[sharpened_circles.id] = sharpened_circles

	var lance_trajectory: Upgrade = Upgrade.new("Lance Trajectory", 301, "Range increased by 200.", 20)
	lance_trajectory.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.range_add += 200
		return stats
	upgrades[lance_trajectory.id] = lance_trajectory

	var true_strike: Upgrade = Upgrade.new("True Strike", 302, "Crit multiplier increased by +0.5.", 35)
	true_strike.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.crit_mod_add += 0.5
		return stats
	upgrades[true_strike.id] = true_strike

	var deadeye_core: Upgrade = Upgrade.new("Deadeye Core", 303, "Crit multiplier increased by 25%.", 65)
	deadeye_core.relies_on = [302]
	deadeye_core.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.crit_mod_mul += 0.25
		return stats
	upgrades[deadeye_core.id] = deadeye_core

	var sniper_poise: Upgrade = Upgrade.new("Sniper's Poise", 304, "Range increased by 20%.", 60)
	sniper_poise.relies_on = [302]
	sniper_poise.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.range_mul += 0.2
		return stats
	upgrades[sniper_poise.id] = sniper_poise

	# -------------------------------
	# Balanced Focus Path
	# -------------------------------

	var stable_circle: Upgrade = Upgrade.new("Stable Circle", 400, "Range increased by 100.", 15)
	stable_circle.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.range_add += 100
		return stats
	upgrades[stable_circle.id] = stable_circle

	var efficient_coating: Upgrade = Upgrade.new("Efficient Coating", 401, "Projectile speed increased by 75.", 15)
	efficient_coating.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.projectile_speed_add += 75
		return stats
	upgrades[efficient_coating.id] = efficient_coating

	var hardened_core: Upgrade = Upgrade.new("Hardened Core", 402, "Crit chance increased by 5%.", 15)
	hardened_core.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.crit_chance_add += 0.05
		return stats
	upgrades[hardened_core.id] = hardened_core

	var core_sync: Upgrade = Upgrade.new("Core Sync", 403, "Attack speed increased by 0.05.", 25)
	core_sync.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.attack_speed_add += 0.05
		return stats
	upgrades[core_sync.id] = core_sync

	var refined_edges: Upgrade = Upgrade.new("Refined Edges", 404, "Damage increased by 10%.", 45)
	refined_edges.relies_on = [403]
	refined_edges.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.damage_mul += 0.1
		return stats
	upgrades[refined_edges.id] = refined_edges

	# -------------------------------
	# Piercing Path
	# -------------------------------

	var piercing_runes: Upgrade = Upgrade.new("Piercing Runes", 500, "Projectiles pierce +1 target.", 20)
	piercing_runes.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 1
		return stats
	upgrades[piercing_runes.id] = piercing_runes

	var core_needle: Upgrade = Upgrade.new("Core Needle", 501, "Projectiles pierce +1 target.", 25)
	core_needle.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 1
		return stats
	upgrades[core_needle.id] = core_needle

	var arc_drill: Upgrade = Upgrade.new("Arc Drill", 502, "Projectiles pierce +2 targets.", 40)
	arc_drill.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 2
		return stats
	upgrades[arc_drill.id] = arc_drill

	var layerbreaker: Upgrade = Upgrade.new("Layerbreaker", 503, "Projectiles pierce +3 targets.", 60)
	layerbreaker.stats_mod = func(stats: CircleStats) -> CircleStats:
		stats.pierce_add += 3
		return stats
	upgrades[layerbreaker.id] = layerbreaker
	
	registry["circle"] = upgrades

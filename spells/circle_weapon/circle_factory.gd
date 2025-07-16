extends SpellFactory

@export var spell: PackedScene
var stats: CircleStats


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spell_name = "circle"
	stats = CircleStats.new()
	stats.attack_speed = 1.8
	stats.damage = 40
	stats.range = 500
	stats.explosive = false
	stats.explosion_radius = 0.0
	stats.explosion_mod = 1.0
	stats.projectile_speed = 400
	stats.crit_chance = 0.1
	stats.crit_mod = 2.0
	stats.pierce = 1
	set_attack_speed(stats.attack_speed)
	#add_upgrade(202)
	#print(get_qualified_upgrades())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_fireball() -> void:
	var attack: Fireball = spell.instantiate()
	attack.position = global_position
	attack.stats = stats
	get_tree().get_nodes_in_group("main")[0].add_child(attack)
	#print(stats.attack_speed_add)


func _on_attack_timer_timeout() -> void:
	if get_tree().get_nodes_in_group("mobs").filter(func(mob: RigidBody2D): return global_position.distance_to(mob.position) <= stats.range).size() > 0:
		spawn_fireball()
		hide()
		await get_tree().create_timer($AttackTimer.wait_time / 2).timeout
		show()

func set_attack_speed(aps: float):
	$AttackTimer.wait_time = 1/aps
	print(str("aps ", aps))
	print(str("time ", 1/aps))
	

# Example to loop properties
func print_user_defined_fields(obj):
	var props = obj.get_property_list()
	for prop in props:
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			var name = prop.name
			var value = obj.get(name)
			print(name, ": ", value)

func add_upgrade(upgrade_id: int):
	upgrades.append(upgrade_id)
	var upgrade = Upgrades.get_upgrade(upgrade_id)
	stats = upgrade.stats_mod.call(stats)
	set_attack_speed((stats.attack_speed+stats.attack_speed_add) * stats.attack_speed_mul)
	#print(upgrades)

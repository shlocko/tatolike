extends SpellFactory

@export var spell: PackedScene
var stats: FireballStats


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stats = FireballStats.new()
	set_attack_speed(randf_range(0.5, 1.0))
	stats.damage = Stat.new()._initialize(50, 10)
	stats.range = Stat.new()._initialize(500, 10)
	stats.explosive = Stat.new()._initialize(false, 100)
	stats.explosion_radius = 0.0
	stats.explosion_mod = 1.0
	stats.projectile_speed = 400
	stats.crit_chance = 0.1
	stats.crit_mod = 2.0
	print(stats.get_dict())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_fireball() -> void:
	var attack: Fireball = spell.instantiate()
	attack.position = global_position
	attack.stats = stats
	get_tree().get_nodes_in_group("main")[0].add_child(attack)


func _on_attack_timer_timeout() -> void:
	if get_tree().get_nodes_in_group("mobs").filter(func(mob: RigidBody2D): return global_position.distance_to(mob.position) <= stats.range).size() > 0:
		spawn_fireball()

func set_attack_speed(time: float):
	stats.attack_speed = time
	$attackTimer.wait_time = time
	

# Example to loop properties
func print_user_defined_fields(obj):
	var props = obj.get_property_list()
	for prop in props:
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			var name = prop.name
			var value = obj.get(name)
			print(name, ": ", value)

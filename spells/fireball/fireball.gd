extends Area2D

class_name Fireball

var active = false
var velocity = Vector2.ZERO
var stats: FireballStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	launch()
	active = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		position += velocity * delta


func launch() -> void:
	var mobs = get_tree().get_nodes_in_group("mobs")
	var nearest = mobs[0]
	for mob in mobs:
		var maybe_nearest = position.distance_to(mob.position)
		if maybe_nearest < position.distance_to(nearest.position):
			nearest = mob
	
	velocity = position.direction_to(nearest.position) * stats.projectile_speed
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	var damage = stats.damage
	if(randf_range(0, 1) < stats.crit_chance):
		print("crit")
		damage *= stats.crit_mod
	body.health -= damage
	queue_free()

extends Area2D

class_name Arrow

var active = false
var velocity = Vector2.ZERO
var stats: ArrowStats
var pierce_health: int
var pierce_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	launch()
	active = true
	pierce_health = stats.get_pierce()
	

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
	$Sprite2D.rotation = global_position.direction_to(nearest.position).angle() + (PI / 2)
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	var damage = stats.get_damage()
	if(randf_range(0, 1) < stats.get_crit_chance()):
		damage *= stats.get_crit_mod()
	body.hit(damage - (damage * stats.get_pierce_degradation() * pierce_count), velocity.normalized()*30)
	pierce_count += 1
	if pierce_count >= pierce_health:
		queue_free()

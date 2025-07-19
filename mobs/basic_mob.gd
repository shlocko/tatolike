extends RigidBody2D

@export var speed: int
@export var health: int
@export var value: int

var knockback: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var player_position = get_tree().get_nodes_in_group("player")[0].position
	var direction = position.direction_to(player_position).normalized()
	knockback = knockback.lerp(Vector2.ZERO, 0.25)
	
	velocity = direction * speed
	if(knockback.length() > 5):
		linear_velocity = knockback
	else:
		linear_velocity = velocity
	
	if health <= 0:
		GlobalState.mob_died(value)
		queue_free()

func hit(damage: int, knockback_effect: Vector2):
	health -= damage
	knockback = 10*knockback_effect

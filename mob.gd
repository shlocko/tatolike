extends RigidBody2D

@export var speed: int
@export var health: int
@export var value: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var player_position = get_tree().get_nodes_in_group("player")[0].position
	var direction = position.direction_to(player_position).normalized()
	
	velocity = direction * speed
	linear_velocity = velocity
	
	if health <= 0:
		GlobalState.mob_died(value)
		queue_free()

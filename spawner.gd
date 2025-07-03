extends Marker2D

@export var marker: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_enemy(mob: PackedScene):
	var main = get_tree().get_nodes_in_group("main")[0]
	var direction = Vector2(1, 0)
	var length = randf_range(0, 150)
	direction = direction.rotated(randf()).normalized() * length
	var location = position + direction
	var spawn_marker = marker.instantiate()
	spawn_marker.position = location
	spawn_marker.position = spawn_marker.position.clamp(Vector2(15, 0), GlobalState.play_area)
	spawn_marker.mob = mob
	main.add_child(spawn_marker)
	

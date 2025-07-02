extends Sprite2D

var mob: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy = mob.instantiate()
	enemy.position = position
	await get_tree().create_timer(1.0).timeout
	get_tree().get_nodes_in_group("main")[0].add_child(enemy)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

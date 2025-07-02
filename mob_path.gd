extends Path2D

@export var mob_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_enemy(count: int):
	for n in count:
		var mob = mob_scene.instantiate()
		var mob_spawn = $MobSpawnPath
		mob_spawn.progress_ratio = randf()
		mob.position = mob_spawn.position
		
		get_tree().get_nodes_in_group("main")[0].add_child(mob)

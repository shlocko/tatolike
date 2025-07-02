extends Node

@export var mob: PackedScene
var spawners: Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawners = []
	spawners.append($Spawner1)
	spawners.append($Spawner2)
	spawners.append($Spawner3)
	spawners.append($Spawner4)
	spawners.append($Spawner5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_mob_timer_timeout() -> void:
	var spawner = spawners.pick_random()
	for n in randi_range(1, 10):
		await get_tree().create_timer(randf_range(0.1, 0.3)).timeout
		spawner.spawn_enemy(mob)
	

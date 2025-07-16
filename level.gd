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
	GlobalState.next_wave.connect(next_wave)
	$WaveTimer.wait_time = 1
	$WaveTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HUD/Timer.text = str(round($WaveTimer.time_left))


func _on_spawn_mob_timer_timeout() -> void:
	var spawner = spawners.pick_random()
	for n in randi_range(max(1, GlobalState.wave / 3), (GlobalState.wave + GlobalState.difficulty_base + round(GlobalState.wave * 0.5))):
		await get_tree().create_timer(randf_range(0.1, 0.3)).timeout
		spawner.spawn_enemy(mob)
	


func _on_wave_timer_timeout() -> void:
	wave_end()

func wave_end():
	$Shop.open()
	get_tree().paused = true

func next_wave():
	$Shop.close()
	GlobalState.wave += 1
	clear_mobs()
	$WaveTimer.start()
	$Player.health += 10
	$HUD/WaveCounter.text = str("Wave ", GlobalState.wave)
	get_tree().paused = false

func clear_mobs():
	for mob in get_tree().get_nodes_in_group("mobs"):
		mob.queue_free()

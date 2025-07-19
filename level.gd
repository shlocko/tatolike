extends Node

var spawners: Array
var mobs: Dictionary


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mobs = {}
	mobs["triangle"] = preload("res://mobs/triangle.tscn")
	mobs["square"] = preload("res://mobs/square.tscn")
	mobs["pentagon"] = preload("res://mobs/pentagon.tscn")
	mobs["hexagon"] = preload("res://mobs/hexagon.tscn")
	mobs["septagon"] = preload("res://mobs/septagon.tscn")
	mobs["octagon"] = preload("res://mobs/octagon.tscn")
	
	spawners = []
	spawners.append($Spawner1)
	spawners.append($Spawner2)
	spawners.append($Spawner3)
	spawners.append($Spawner4)
	spawners.append($Spawner5)
	GlobalState.next_wave.connect(next_wave)
	$WaveTimer.wait_time = 45
	$WaveTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HUD/Timer.text = str(round($WaveTimer.time_left))

func choose_mob():
	var wave = GlobalState.wave
	match wave:
		1,2: return mobs["triangle"]
		3,4,5: return mobs["square"]
		6,7,8: return mobs["pentagon"]
		9,10,11: return mobs["hexagon"]
		12,13,14: return mobs["septagon"]
		_: return mobs["octagon"]
		

func _on_spawn_mob_timer_timeout() -> void:
	var spawner = spawners.pick_random()
	for n in randi_range(max(1, GlobalState.wave / 3), (GlobalState.wave + GlobalState.difficulty_base)):
		await get_tree().create_timer(0.1).timeout
		spawner.spawn_enemy(choose_mob())
	


func _on_wave_timer_timeout() -> void:
	wave_end()

func wave_end():
	$Shop.open()
	clear_entities()
	get_tree().paused = true

func next_wave():
	$Shop.close()
	GlobalState.wave += 1
	clear_entities()
	$WaveTimer.start()
	$Player.health += 10
	$HUD/WaveCounter.text = str("Wave ", GlobalState.wave)
	get_tree().paused = false

func clear_mobs():
	for mob in get_tree().get_nodes_in_group("mobs"):
		mob.queue_free()

func clear_projectiles():
	for projectile in get_tree().get_nodes_in_group("projectile"):
		projectile.queue_free()

func clear_spawn_markers():
	for marker in get_tree().get_nodes_in_group("spawn_markers"):
		marker.queue_free()

func clear_entities():
	clear_mobs()
	clear_projectiles()
	clear_spawn_markers()

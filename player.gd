extends Area2D

@export var speed: int
@export var health: int
@export var max_health: int = 50
@export var spell_count: int
var invulnerable:bool = false
var play_area: Vector2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_area = Vector2(1260, 740)
	$AnimatedSprite2D.animation = "stand"
	position = Vector2(100, 100)
	$attackTimer.start()
	health = max_health
	GlobalState.player_died.connect(die)
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalState.dead:
		return
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_right"
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.animation = "walk_right"
		$AnimatedSprite2D.flip_h = true
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
		$AnimatedSprite2D.flip_h = false
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "stand"
		$AnimatedSprite2D.flip_h = false
		
	
	position += velocity * delta
	position = position.clamp(Vector2(15, 0), play_area)
	
	if health <= 0:
		#get_tree().root.get_node("Main").load_main_menu()
		GlobalState.player_died.emit()
	health = clamp(health, 0, max_health)


func _on_i_frame_timer_timeout() -> void:
	invulnerable = false


func _on_body_entered(body: Node2D) -> void:
	if !invulnerable:
		health -= 15
		invulnerable = true
		$IFrameTimer.start()


func _on_attack_timer_timeout() -> void:
	var mobs = get_tree().get_nodes_in_group("mobs")

func get_spells() -> Array[SpellFactory]:
	var spells: Array[SpellFactory] = []
	var children = $SpellSpawner.get_children()
	for ch in children:
		if ch is SpellFactory:
			spells.append(ch)
	return spells

func die():
	GlobalState.dead = true
	$AnimatedSprite2D.animation = "die"
	$AnimatedSprite2D.flip_h = false

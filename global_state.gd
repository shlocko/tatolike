extends Node

const play_area = Vector2(1260, 740)
var spells: Array[PackedScene]
var spell_count: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in 6:
		spells.append(preload("res://spells/fireball/fireball_factory.tscn"))
	spell_count = spells.size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends Node

var arc: float
var flippity_flop: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var direction = Vector2(0, -50)
	flippity_flop = 1.0
	
	arc = (2*PI)/GlobalState.spell_count
	for spell in GlobalState.spells:
		var spellInstance: SpellFactory = spell.instantiate()
		spellInstance.position = direction
		direction = direction.rotated(arc)
		spellInstance.set_timer_duration(randf_range(0.5, 1.0))
		add_child(spellInstance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for spell in get_children():
		spell.position = spell.position.rotated(flippity_flop * delta)

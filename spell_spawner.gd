extends Node

var arc: float
var flippity_flop: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var direction = Vector2(0, -50)
	flippity_flop = 1.0
	

func add_spell(spell: PackedScene):
	var spellInstance: SpellFactory = spell.instantiate()
	add_child(spellInstance)
	reset_spell_positions()

func reset_spell_positions():
	var direction = Vector2(0, -50)
	var spells := get_children()
	var arc = (2*PI)/(get_children().size())
	for spell in spells:
		spell.position = direction
		direction = direction.rotated(arc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for spell in get_children():
		spell.position = spell.position.rotated(flippity_flop * delta)

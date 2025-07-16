extends Node

const play_area = Vector2(1260, 740)
var money: int
var wave: int
var difficulty_base: int

signal buy_upgrade(spell_id: int, upgrade_id: int, price: int)
signal buy_spell(spell_id: int, price: int)
signal next_wave

var spell_registry: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spell_registry[0] = {
		name = "Circle",
		spell = preload("res://spells/circle_weapon/circle_factory.tscn")
		}
	spell_registry[1] = {
		name = "Arrow",
		spell = preload("res://spells/arrow_weapon/arrow_factory.tscn")
		}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mob_died(value: int):
	money += value

func add_spell(spell: int):
	var spawner = get_tree().get_first_node_in_group("player").get_node("SpellSpawner")
	spawner.add_spell(spell_registry[spell].spell)

func get_spell_count():
	if (get_tree().get_nodes_in_group("player").size() < 1): return 0
	var count = get_tree().get_first_node_in_group("player").get_node("SpellSpawner").get_children().size()
	#print(count)
	return count

func get_max_spell_count():
	var count = floor((wave + difficulty_base)/3) + 1
	return count

func start_game(diff: int):
	money = 10000
	wave = 1
	difficulty_base = diff
	add_spell(1)
	#max_spell_count = floor((wave + difficulty_base) / 5) + 1

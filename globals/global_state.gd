extends Node

const play_area = Vector2(1260, 740)
var spells: Array[PackedScene]
var spell_count: int
var money: int
var wave: int
var difficulty_base: int

signal buy_upgrade(spell_id: int, upgrade_id: int, price: int)
signal next_wave


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func mob_died(value: int):
	money += value

func start_game(diff: int):
	money = 0
	wave = 1
	difficulty_base = diff
	spells = []
	spells.append(preload("res://spells/circle_weapon/circle_factory.tscn"))
	spell_count = spells.size()

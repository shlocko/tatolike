extends Node2D

var current_scene: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_main_menu()

func load_level():
	change_scene("res://level.tscn")

func load_main_menu():
	change_scene("res://UI/main_menu.tscn")

func change_scene(path: String):
	if current_scene:
		current_scene.queue_free()
	current_scene = load(path).instantiate()
	add_child(current_scene)

extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	GlobalState.start_game(0)
	get_tree().root.get_node("Main").load_level()


func _on_quit_button_pressed() -> void:
	get_tree().quit()

extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HP.text = str(get_tree().get_nodes_in_group("player")[0].health)
	$HP.show()
	$Money.text = str("$ ", GlobalState.money)

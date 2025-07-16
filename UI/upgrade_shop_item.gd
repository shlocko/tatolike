extends PanelContainer

var upgrade_id: int
var spell_id: int
var price: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_item_name(s: String):
	$Container/Text/Name.text = s

func set_item_description(s: String):
	$Container/Text/Description.text = s

func set_item_price(s: int):
	$Container/Price.text = str("$", s)
	price = s

func set_buy_enabled(t: bool):
	$Container/Buttons/Buy.disabled = !t


func _on_buy_pressed() -> void:
	print("tist")
	GlobalState.buy_upgrade.emit(spell_id, upgrade_id, price)

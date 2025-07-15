extends CanvasLayer

var spells: Array[SpellFactory]
var shop_index: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spells = get_tree().get_nodes_in_group("player")[0].get_spells()
	GlobalState.connect("buy_upgrade", buy_upgrade)
	shop_refresh_visual()
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shop_index = wrapi(shop_index, 0, spells.size())
	shop_refresh_visual()
	if Input.is_action_just_pressed("select"):
		visible = !visible


func _on_left_button_pressed() -> void:
	shop_left()


func _on_right_button_pressed() -> void:
	shop_right()

func shop_left():
	shop_index -= 1
	shop_index = wrapi(shop_index, 0, spells.size())

func shop_right():
	shop_index += 1
	shop_index = wrapi(shop_index, 0, spells.size())

func shop_reroll(index: int):
	var spell = spells[index]
	spell.upgrades_shop = spell.locked_upgrades_shop.duplicate()
	while spell.upgrades_shop.size() < 4 and spell.get_qualified_upgrades().size() > 0:
		var upgrade_id = spell.get_qualified_upgrades().pick_random()
		while spell.upgrades_shop.has(upgrade_id):
			upgrade_id = spell.get_qualified_upgrades().pick_random()
		spell.upgrades_shop.append(upgrade_id)

func shop_refresh_visual():
	var spell = spells[shop_index]
	$Panel/ShopControlsContainer/SpellName.text = spell.spell_name
	for i in 4:
		var item = $Panel/UpgradesContainer.get_children()[i]
		if i < spell.upgrades_shop.size():
			item.visible = true
			var upgrade_id =  spells[shop_index].upgrades_shop[i]
			var upgrade = Upgrades.get_upgrade(spells[shop_index].spell_name, upgrade_id)
			item.set_item_name(upgrade.upgrade_name)
			item.set_item_description(upgrade.upgrade_text)
			item.set_item_price(upgrade.price)
			item.set_buy_enabled(GlobalState.money >= upgrade.price)
			item.upgrade_id = upgrade_id
			item.spell_id = shop_index
		else:
			item.visible = false
	
	for child in $Panel/StatsContainer.get_children():
		child.queue_free()
	
	var getter_dict = spell.stats.get_named_stat_getters()
	for name in getter_dict:
		var stat_bar = preload("res://stat_line.tscn").instantiate()
		stat_bar.get_node("Container/StatName").text = name
		stat_bar.get_node("Container/StatLevel").text = str(getter_dict[name].call())
		$Panel/StatsContainer.add_child(stat_bar)



func _on_reroll_button_pressed() -> void:
	shop_reroll(shop_index)

func buy_upgrade(spell_id, upgrade_id, price):
	var spell = spells[spell_id]
	spell.add_upgrade(upgrade_id)
	GlobalState.money -= price
	spell.upgrades_shop.remove_at(spell.upgrades_shop.find(upgrade_id))
	

extends CanvasLayer

var spells: Array[SpellFactory]
var shop_index: int = 0
var upgrade_reroll_cost: int = GlobalState.wave
var spell_reroll_cost: int = GlobalState.wave * 10
var spell_purchase: int = 0
var spell_price: int = 50 + GlobalState.get_spell_count()*20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spells = get_tree().get_nodes_in_group("player")[0].get_spells()
	GlobalState.connect("buy_upgrade", buy_upgrade)
	GlobalState.connect("buy_spell", buy_spell)
	shop_refresh_visual()
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shop_index = clamp(shop_index, 0, spells.size())
	shop_refresh_visual()


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

func upgrade_shop_reroll(index: int):
	var spell = spells[index]
	spell.upgrades_shop = spell.locked_upgrades_shop.duplicate()
	while spell.upgrades_shop.size() < 4 and spell.get_qualified_upgrades().size() > spell.upgrades_shop.size():
		var upgrade_id = spell.get_qualified_upgrades().pick_random()
		while spell.upgrades_shop.has(upgrade_id):
			upgrade_id = spell.get_qualified_upgrades().pick_random()
		spell.upgrades_shop.append(upgrade_id)


func spell_shop_reroll():
	spell_purchase = randi_range(0, GlobalState.spell_registry.size()-1)
	$LeftPanel/SpellShopContainer/SpellShopItem.set_item_spell(spell_purchase)

func shop_refresh_visual():
	spells = get_tree().get_nodes_in_group("player")[0].get_spells()
	
	# -------------------
	# Right Panel
	# -------------------
	if spells.size() < 1:
		return
	
	var spell = spells[shop_index]
	$RightPanel/Money.text = str("$", GlobalState.money)
	$RightPanel/ShopControlsContainer/SpellName.text = spell.spell_name
	for i in 4:
		var item = $RightPanel/UpgradesContainer.get_children()[i]
		if i < spell.upgrades_shop.size():
			item.visible = true
			var upgrade_id =  spells[shop_index].upgrades_shop[i]
			var upgrade = Upgrades.get_upgrade(upgrade_id)
			item.set_item_name(upgrade.upgrade_name)
			item.set_item_description(upgrade.upgrade_text)
			item.set_item_price(upgrade.price)
			item.set_buy_enabled(GlobalState.money >= upgrade.price)
			item.upgrade_id = upgrade_id
			item.spell_id = shop_index
		else:
			item.visible = false
	for child in $RightPanel/StatsContainer.get_children():
		child.queue_free()
	var getter_dict = spell.stats.get_named_stat_getters()
	for name in getter_dict:
		var stat_bar = preload("res://UI/stat_line.tscn").instantiate()
		stat_bar.get_node("Container/StatName").text = name
		stat_bar.get_node("Container/StatLevel").text = str(getter_dict[name].call())
		$RightPanel/StatsContainer.add_child(stat_bar)
	$RightPanel/UpgradeRerollButton.text = str("Reroll - $", upgrade_reroll_cost)
	if GlobalState.money >= upgrade_reroll_cost:
		$RightPanel/UpgradeRerollButton.disabled = false
	else:
		$RightPanel/UpgradeRerollButton.disabled = true
	
	# -------------------
	# Left Panel
	# -------------------
	
	if GlobalState.money >= spell_reroll_cost:
		$LeftPanel/SpellShopContainer/SpellRerollButton.disabled = false
	else:
		$LeftPanel/SpellShopContainer/SpellRerollButton.disabled = true
	$LeftPanel/SpellShopContainer.visible = GlobalState.get_spell_count() < GlobalState.get_max_spell_count()
		
	$LeftPanel/SpellShopContainer/SpellRerollButton.text = str("Reroll - $", spell_reroll_cost)
	$LeftPanel/SpellShopContainer/SpellShopItem.set_item_name(GlobalState.spell_registry[spell_purchase].name)
	$LeftPanel/SpellShopContainer/SpellShopItem.set_item_price(spell_price)
	$LeftPanel/SpellShopContainer/SpellShopItem.set_buy_enabled(GlobalState.money >= spell_price)


func open():
	spells = get_tree().get_nodes_in_group("player")[0].get_spells()
	for i in spells.size():
		upgrade_shop_reroll(i)
	upgrade_reroll_cost = GlobalState.wave
	spell_shop_reroll()
	spell_reroll_cost = GlobalState.wave * 10
	spell_price = 30 + GlobalState.get_spell_count()*20
	shop_index = 0
	visible = true

func close():
	visible = false


func _on_upgrade_reroll_button_pressed() -> void:
	upgrade_shop_reroll(shop_index)
	GlobalState.money -= upgrade_reroll_cost
	upgrade_reroll_cost = round(upgrade_reroll_cost * 1.2) + 1


func _on_spell_reroll_button_pressed() -> void:
	spell_shop_reroll()
	GlobalState.money -= spell_reroll_cost
	spell_reroll_cost = round(spell_reroll_cost * 1.2) + 5


func buy_upgrade(spell_id, upgrade_id, price):
	var spell = spells[spell_id]
	spell.add_upgrade(upgrade_id)
	GlobalState.money -= price
	spell.upgrades_shop.remove_at(spell.upgrades_shop.find(upgrade_id))


func buy_spell(spell_id, price):
	GlobalState.money -= price
	GlobalState.add_spell(spell_id)


func _on_next_wave_button_pressed() -> void:
	GlobalState.next_wave.emit()

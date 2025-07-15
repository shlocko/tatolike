extends Marker2D
class_name SpellFactory

var locked_upgrades_shop: Array[int] = []
var upgrades_shop: Array[int] = []
var spell_name: String
var upgrades: Array[int] = []


func set_timer_duration(time: float) -> void:
	pass


func get_qualified_upgrades() -> Array[int]:
	var arr: Array[int] = []
	for id in Upgrades.get_all_from_spell("general"):
		var qualified = true
		if(upgrades.has(id)): qualified = false
		for rely_id in Upgrades.get_upgrade(id).relies_on:
			if(not upgrades.has(rely_id)):
				qualified = false
		if qualified: arr.append(id)
	for id in Upgrades.get_all_from_spell(spell_name):
		var qualified = true
		if(upgrades.has(id)): qualified = false
		for rely_id in Upgrades.get_upgrade(id).relies_on:
			if(not upgrades.has(rely_id)):
				qualified = false
		if qualified: arr.append(id)
	return arr

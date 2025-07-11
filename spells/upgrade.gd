extends Node

class_name Upgrade

var upgrade_name: String
var id: int
var upgrade_text: String
var price: int
var relies_on: Array[int]

var stats_mod: Callable = func (stats) -> Variant:
	return stats

func _init(name: String, id: int, text: String, price: int):
	upgrade_name = name
	self.id = id
	upgrade_text = text
	self.price = price

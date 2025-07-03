extends Node

class_name Stat

var value
var upgrade_cost: float
var level: int

func _initialize(value, upgrade_cost: float, cost_mult: float, level: int = 0):
	self.value = value
	self.upgrade_cost = upgrade_cost
	self.level = level

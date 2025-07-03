extends Node

class_name FireballStats

var attack_speed: Stat
var range: Stat
var damage: Stat
var explosive: bool
var explosion_radius: Stat
var explosion_mod: Stat
var projectile_speed: Stat
var crit_chance: Stat
var crit_mod: Stat

func get_dict():
	var props = self.get_property_list()
	var dict = {}
	for prop in props:
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			var name = prop.name
			var value = self.get(name)
			dict[name] = value
	return dict

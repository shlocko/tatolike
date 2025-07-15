extends Node

class_name Stats

var attack_speed: float
var range: float
var damage: float
var explosive: bool
var explosion_radius: float
var explosion_mod: float
var projectile_speed: float
var crit_chance: float
var crit_mod: float
var pierce: int


# Additive upgrades
var attack_speed_add: float = 0.0
var range_add: float = 0.0
var damage_add: float = 0.0
var explosion_radius_add: float = 0.0
var explosion_mod_add: float = 0.0
var projectile_speed_add: float = 0.0
var crit_chance_add: float = 0.0
var crit_mod_add: float = 0.0
var pierce_add: int = 0

# Multiplicative upgrades
var attack_speed_mul: float = 1.0
var range_mul: float = 1.0
var damage_mul: float = 1.0
var explosion_radius_mul: float = 1.0
var explosion_mod_mul: float = 1.0
var projectile_speed_mul: float = 1.0
var crit_chance_mul: float = 1.0
var crit_mod_mul: float = 1.0

func print_upgrades():
	print(str(attack_speed_mul, range_mul, damage_mul, explosion_radius_mul, explosion_mod_mul, " ", crit_chance_mul, " ", crit_mod_mul))


func get_attack_speed() -> float:
	return (attack_speed + attack_speed_add) * attack_speed_mul

func get_range() -> float:
	return (range + range_add) * range_mul

func get_damage() -> float:
	return (damage + damage_add) * damage_mul

func get_explosion_radius() -> float:
	return (explosion_radius + explosion_radius_add) * explosion_radius_mul

func get_explosion_mod() -> float:
	return (explosion_mod + explosion_mod_add) * explosion_mod_mul

func get_projectile_speed() -> float:
	return (projectile_speed + projectile_speed_add) * projectile_speed_mul

func get_crit_chance() -> float:
	return (crit_chance + crit_chance_add) * crit_chance_mul

func get_crit_mod() -> float:
	return (crit_mod + crit_mod_add) * crit_mod_mul

func get_pierce() -> int:
	return pierce + pierce_add

func is_explosive() -> bool:
	return explosive

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
var pierce_degradation: float


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
var pierce_degradation_add: float = 0.0

# Multiplicative upgrades
var attack_speed_mul: float = 1.0
var range_mul: float = 1.0
var damage_mul: float = 1.0
var explosion_radius_mul: float = 1.0
var explosion_mod_mul: float = 1.0
var projectile_speed_mul: float = 1.0
var crit_chance_mul: float = 1.0
var crit_mod_mul: float = 1.0
var pierce_degradation_mul: float = 1.0


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

func get_pierce_degradation() -> float:
	return (pierce_degradation + pierce_degradation_add) * pierce_degradation_mul

func get_degraded_damage(damage: float, hits: int) -> float:
	var degraded_damage = clamp(damage - (damage * get_pierce_degradation() * hits), damage * 0.1, damage)
	return degraded_damage

func is_explosive() -> bool:
	return explosive


func get_named_stat_getters() -> Dictionary:
	return {
		"attack_speed": Callable(self, "get_attack_speed"),
		"range": Callable(self, "get_range"),
		"damage": Callable(self, "get_damage"),
		"explosion_radius": Callable(self, "get_explosion_radius"),
		"explosion_mod": Callable(self, "get_explosion_mod"),
		"projectile_speed": Callable(self, "get_projectile_speed"),
		"crit_chance": Callable(self, "get_crit_chance"),
		"crit_mod": Callable(self, "get_crit_mod"),
		"pierce": Callable(self, "get_pierce"),
		"pierce_degradation": Callable(self, "get_pierce_degradation"),
		"explosive": Callable(self, "is_explosive")
	}

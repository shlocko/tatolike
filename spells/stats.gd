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

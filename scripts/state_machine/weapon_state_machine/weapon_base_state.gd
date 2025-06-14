extends Node
class_name WeaponBaseState

signal transitioned

@export var animation_name: String
@export var current_weapon: String

var weapon: Area2D
var animation: AnimatedSprite2D

func enter() -> void:
	
	animation.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> void:
	pass

func process_frame(_delta: float) -> void:
	var angle = (weapon.get_global_mouse_position() - weapon.global_position).angle()
	weapon.look_at(weapon.get_global_mouse_position())
	animation.flip_v = abs(rad_to_deg(angle)) > 90

func process_physics(_delta: float) -> void:
	pass

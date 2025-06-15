extends Node
class_name WeaponBaseState

signal transitioned

@export var animation_name: String
@export var current_weapon: String
@export var delay_duration: float
@export var move_speed_with_weapon: float

var weapon: Area2D
var animation: AnimatedSprite2D
var input_enabled: bool = false

var delay_remaining: float = 0.0
var delay_active: bool = false

func enter() -> void:
	animation.play(animation_name)
	init_delay()

func exit() -> void:
	pass

func process_frame(delta: float) -> void:
	exec_delay(delta)
	var angle = (weapon.get_global_mouse_position() - weapon.global_position).angle()
	weapon.look_at(weapon.get_global_mouse_position())
	animation.flip_v = abs(rad_to_deg(angle)) > 90

func process_physics(_delta: float) -> void:
	pass

func init_delay() -> void:
	delay_remaining = delay_duration
	delay_active = delay_duration > 0
	input_enabled = !delay_active

func exec_delay(delta: float) -> void:
	if delay_active:
		delay_remaining -= delta
		if delay_remaining <= 0:
			delay_active = false
			input_enabled = true

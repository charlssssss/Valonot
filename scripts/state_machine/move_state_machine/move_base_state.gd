extends Node
class_name MoveBaseState

signal transitioned

@export var animation_name: String
@export var move_speed: float = 400

var char_body: CharacterBody2D
var animation: AnimatedSprite2D
var weapon_state_machine: WeaponStateMachine

func enter() -> void:
	animation.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> void:
	pass

func process_frame(_delta: float) -> void:
	animation.flip_h = char_body.get_global_mouse_position() < char_body.position

func process_physics(_delta: float) -> void:
	pass

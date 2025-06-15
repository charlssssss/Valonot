extends CharacterBody2D
class_name Agent

@export var animation: AnimatedSprite2D
@export var move_state_machine: MoveStateMachine
@export var weapon_component: Area2D

func _ready() -> void:
	var weapon_state_machine: WeaponStateMachine = weapon_component.get_node("weapon_state_machine")
	move_state_machine.init(self, animation, weapon_state_machine)

func _unhandled_input(event: InputEvent) -> void:
	move_state_machine.process_input(event)
	
func _process(delta: float) -> void:
	move_state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	move_state_machine.process_physics(delta)

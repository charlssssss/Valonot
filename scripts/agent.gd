extends CharacterBody2D
class_name Agent

@export var animation: AnimatedSprite2D
@export var move_state_machine: MoveStateMachine

func _ready() -> void:
	move_state_machine.init(self, animation)

func _unhandled_input(event: InputEvent) -> void:
	move_state_machine.process_input(event)
	
func _process(delta: float) -> void:
	move_state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	move_state_machine.process_physics(delta)

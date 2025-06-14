extends Node
class_name  MoveStateMachine

@export var initial_state: MoveBaseState

var current_state: MoveBaseState
var states: Dictionary = {}

func init(char_body: CharacterBody2D, animation: AnimatedSprite2D) -> void:
	for child in get_children():
		if child is MoveBaseState:
			states[child.name.to_lower()] = child
			child.char_body = char_body
			child.animation = animation
			child.transitioned.connect(on_child_transition)
		
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func process_input(event: InputEvent) -> void:
	if current_state:
		current_state.process_input(event)

func process_frame(delta: float) -> void:
	if current_state:
		current_state.process_frame(delta)

func process_physics(delta: float) -> void:
	if current_state:
		current_state.process_physics(delta)

func on_child_transition(state: MoveBaseState, new_state_name: String):
	if state != current_state:
		return
	
	var new_state: MoveBaseState = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state

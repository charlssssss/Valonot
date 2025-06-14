extends Node
class_name  WeaponStateMachine

@export var initial_state: WeaponBaseState

var current_state: WeaponBaseState
var states: Dictionary = {}
var weapon_animations: Dictionary = {}

func init(weapon: Area2D, animations: Dictionary) -> void:
	weapon_animations = animations
	for child in get_children():
		if child is WeaponBaseState:
			var child_name = child.name.to_lower()
			states[child_name] = child
			child.weapon = weapon
			child.animation = animations.get(child_name)
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

func on_child_transition(state: WeaponBaseState, new_state_name: String):
	if state != current_state: 
		return
	
	var new_state: WeaponBaseState = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	
	if new_state_name == "fire":
		new_state.animation = state.animation
		new_state.current_weapon = state.current_weapon
	
	new_state.enter()
	hide_other_weapons(new_state_name)
	current_state = new_state

func hide_other_weapons(new_weapon: String) -> void:
	if new_weapon == "fire":
		return
	
	for weapon_name in weapon_animations.keys():
		var sprite = weapon_animations[weapon_name]
		sprite.visible = (weapon_name == new_weapon)
	

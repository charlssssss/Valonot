extends Node
class_name  WeaponStateMachine

@export var initial_state: WeaponBaseState
@export var change_weapon_timer: Timer

var current_state: WeaponBaseState
var states: Dictionary = {}
var weapons: Dictionary = {}
var is_done_weapon_change: bool = false

func init(weapon: Area2D, weapon_components: Dictionary) -> void:
	weapons = weapon_components
	for child in get_children():
		if child is WeaponBaseState:
			var child_name = child.name.to_lower()
			states[child_name] = child
			child.weapon = weapon
			child.weapons = weapons.get(child_name)
			child.transitioned.connect(on_child_transition)
		
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		start_change_weapon_timer()

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
	
	if new_state_name == "fire" && !is_done_weapon_change:
		return
	
	var new_state: WeaponBaseState = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	if new_state_name == "fire":
		new_state.animation = state.animation
		new_state.current_weapon = state.current_weapon
		new_state.move_speed_with_weapon = state.move_speed_with_weapon
	
	hide_other_weapons(new_state_name)
	new_state.enter()
	current_state = new_state
	start_change_weapon_timer()

func hide_other_weapons(new_weapon: String) -> void:
	if new_weapon == "fire":
		return
	
	for weapon_name in weapons.keys():
		var component = weapons[weapon_name]
		component.visible = (weapon_name == new_weapon)
	
func get_move_speed_with_weapon() -> float:
	if current_state:
		return current_state.move_speed_with_weapon
	
	return 0

func start_change_weapon_timer():
	change_weapon_timer.stop()
	is_done_weapon_change = false
	change_weapon_timer.start()

func _on_change_weapon_timer_timeout():
	is_done_weapon_change = true

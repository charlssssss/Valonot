extends Area2D
class_name Weapon

@export var weapon_pivot: Marker2D
@export var weapon_state_machine: WeaponStateMachine

var weapon_components: Dictionary = {}

func _ready() -> void:
	for child in weapon_pivot.get_children():
		if child is Area2D:
			weapon_components[child.name.to_lower()] = child
		
	weapon_state_machine.init(self, weapon_components)

func _unhandled_input(event: InputEvent) -> void:
	weapon_state_machine.process_input(event)
	
func _process(delta: float) -> void:
	weapon_state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	weapon_state_machine.process_physics(delta)

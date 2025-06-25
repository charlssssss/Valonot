extends CharacterBody2D
class_name Agent

signal game_over

@export var animation: AnimatedSprite2D
@export var move_state_machine: MoveStateMachine
@export var weapon_component: Area2D

@export var health_bar: ProgressBar
@export var health: int = 100

func _ready() -> void:
	health_bar.init_health(health)
	var weapon_state_machine: WeaponStateMachine = weapon_component.get_node("weapon_state_machine")
	move_state_machine.init(self, animation, weapon_state_machine)

func _unhandled_input(event: InputEvent) -> void:
	move_state_machine.process_input(event)
	
func _process(delta: float) -> void:
	move_state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	move_state_machine.process_physics(delta)

func take_damage(damage: int) -> void:
	if health > 0:
		health -= damage
		health_bar.health = health
	else:
		game_over.emit()

extends CharacterBody2D

@export var bot_state_machine: BotStateMachine
@export var health_bar: ProgressBar
@export var health: int = 100

func _ready() -> void:
	var animation = get_bot_animation()
	health_bar.init_health(health)
	bot_state_machine.init(self, animation)

func _unhandled_input(event: InputEvent) -> void:
	bot_state_machine.process_input(event)
	
func _process(delta: float) -> void:
	bot_state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	bot_state_machine.process_physics(delta)

func take_damage(damage: int) -> void:
	health -= damage
	health_bar.health = health
	if health <= 0:
		queue_free()

func get_bot_animation() -> AnimatedSprite2D:
	var animation: AnimatedSprite2D
	for child in get_children():
		if child is AnimatedSprite2D:
			animation = child
			break
	
	return animation

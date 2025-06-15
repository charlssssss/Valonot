extends CharacterBody2D

@export var health_bar: ProgressBar
@export var health: int = 100

func _ready() -> void:
	health_bar.init_health(health)

func take_damage(damage: int) -> void:
	health -= damage
	health_bar.health = health
	if health <= 0:
		queue_free()

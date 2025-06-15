extends CharacterBody2D

var health: int = 20

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()

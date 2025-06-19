extends Area2D

@export var travelled_distance: float = 0
@export var damage: int = 10
@export var speed: int = 200
@export var bullet_range: int = 200

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	var distance = speed * delta
	
	position += direction * distance
	travelled_distance += distance
	
	if travelled_distance > bullet_range:
		queue_free()

func _on_body_entered(body: CharacterBody2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)

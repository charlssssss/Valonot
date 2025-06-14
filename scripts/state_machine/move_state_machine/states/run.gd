extends MoveBaseState

@export var idle_state: MoveBaseState

func enter() -> void:
	animation.play(animation_name)

func process_physics(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction == Vector2.ZERO:
		transitioned.emit(self, "idle")
	
	direction = direction.normalized()
	char_body.velocity = direction * move_speed
	char_body.move_and_slide()

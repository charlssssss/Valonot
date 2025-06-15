extends MoveBaseState

func process_physics(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction == Vector2.ZERO:
		transitioned.emit(self, "idle")
	
	var current_speed = move_speed
	if weapon_state_machine:
		current_speed = weapon_state_machine.get_move_speed_with_weapon()
	
	direction = direction.normalized()
	char_body.velocity = direction * current_speed
	char_body.move_and_slide()

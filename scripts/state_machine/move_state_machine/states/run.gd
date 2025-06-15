extends MoveBaseState

func process_physics(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction == Vector2.ZERO:
		transitioned.emit(self, "idle")
	
	var current_speed = move_speed
	
	var move_speed_with_weapon = weapon_state_machine.get_move_speed_with_weapon() if weapon_state_machine else 0.0
	if move_speed_with_weapon > 0.0:
		current_speed = move_speed_with_weapon
	
	direction = direction.normalized()
	char_body.velocity = direction * current_speed
	char_body.move_and_slide()

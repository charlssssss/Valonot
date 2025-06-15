extends WeaponBaseState

func process_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		transitioned.emit(self, "fire")
	elif Input.is_action_just_pressed("change_to_secondary"):
		transitioned.emit(self, "secondary")
	elif Input.is_action_just_pressed("change_to_melee"):
		transitioned.emit(self, "melee")

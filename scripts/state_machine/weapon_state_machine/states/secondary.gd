extends WeaponBaseState

func enter() -> void:
	print("CHANGED TO SECONDARY!")

func process_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		transitioned.emit(self, "fire")
	elif Input.is_action_just_pressed("change_to_melee"):
		transitioned.emit(self, "melee")
	elif Input.is_action_just_pressed("change_to_primary"):
		transitioned.emit(self, "primary")

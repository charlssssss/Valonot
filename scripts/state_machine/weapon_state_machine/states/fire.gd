extends WeaponBaseState

func play_weapon_animation() -> void:
	var weapon_animation = current_weapon + "_fire"
	animation.play(weapon_animation)

func enter() -> void:
	play_weapon_animation()

func process_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		animation.stop()
		play_weapon_animation()
	elif Input.is_action_just_pressed("change_to_primary"):
		transitioned.emit(self, "primary")
	elif Input.is_action_just_pressed("change_to_secondary"):
		transitioned.emit(self, "secondary")
	elif Input.is_action_just_pressed("change_to_melee"):
		transitioned.emit(self, "melee")

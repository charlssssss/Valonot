extends WeaponBaseState

func enter() -> void:
	super.init_delay()
	play_weapon_animation()

func process_input(_event: InputEvent) -> void:
	if !input_enabled:
		return
	if Input.is_action_just_pressed("fire"):
		play_weapon_animation()
	elif Input.is_action_just_pressed("change_to_primary"):
		transitioned.emit(self, "primary")
	elif Input.is_action_just_pressed("change_to_secondary"):
		transitioned.emit(self, "secondary")
	elif Input.is_action_just_pressed("change_to_melee"):
		transitioned.emit(self, "melee")

func play_weapon_animation() -> void:
	animation.stop()
	if !input_enabled:
		return
	var weapon_animation = current_weapon + "_fire"
	animation.play(weapon_animation)

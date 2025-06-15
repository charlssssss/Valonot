extends WeaponBaseState

func enter() -> void:
	fire_bullet()

func process_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		fire_bullet()
	elif Input.is_action_just_pressed("change_to_primary"):
		transitioned.emit(self, "primary")
	elif Input.is_action_just_pressed("change_to_secondary"):
		transitioned.emit(self, "secondary")
	elif Input.is_action_just_pressed("change_to_melee"):
		transitioned.emit(self, "melee")

func play_weapon_animation() -> void:
	animation.stop()
	var weapon_animation = current_weapon + "_fire"
	animation.play(weapon_animation)
	
func fire_bullet() -> void:
	play_weapon_animation()
	
	var fire_point = animation.get_child(0) if animation.get_child_count() > 0 else null
	if fire_point == null:
		return
	
	var bullet_scene = load("res://scenes/weapons/bullet.tscn")
	if bullet_scene == null:
		return
	
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = fire_point.global_position
	new_bullet.global_rotation = fire_point.global_rotation
	fire_point.add_child(new_bullet)

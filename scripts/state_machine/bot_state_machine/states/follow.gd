extends BotBaseState

func enter() -> void:
	animation.play(animation_name)

func process_physics(_delta: float) -> void:
	follow_enemy()

func follow_enemy() -> void:
	if !enemy_body:
		return
	var direction = char_body.global_position.direction_to(enemy_body.global_position)
	animation.flip_h = direction.x < 0
	char_body.velocity = direction * move_speed
	char_body.move_and_slide()

func _on_bot_range_body_exited(_body: Node2D) -> void:
	transitioned.emit(self, "wander", null)

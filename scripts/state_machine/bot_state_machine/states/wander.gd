extends BotBaseState

var move_direction: Vector2
var wander_time: float

func enter() -> void:
	animation.play(animation_name)
	randomize_wander()

func process_frame(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	animation.flip_h = move_direction.x < 0

func process_physics(_delta: float) -> void:
	char_body.velocity = move_direction * move_speed
	char_body.move_and_slide()

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 2)).normalized()
	wander_time = randf_range(1, 3)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body is CharacterBody2D:
		return
	transitioned.emit(self, "follow", body)

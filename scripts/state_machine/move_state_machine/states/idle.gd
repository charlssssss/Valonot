extends MoveBaseState

@export var move_state: MoveBaseState

func enter() -> void:
	animation.play(animation_name)
	char_body.velocity = Vector2.ZERO

func process_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down") or  Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		transitioned.emit(self, "run")

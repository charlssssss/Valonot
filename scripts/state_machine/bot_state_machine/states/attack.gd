extends BotBaseState

@export var shooting_point: Marker2D
@export var weapon_pivot: Marker2D
@export var weapon_sprite: AnimatedSprite2D

var has_enemy: bool = false

func enter() -> void:
	animation.play(animation_name)

func process_physics(_delta: float) -> void:
	has_enemy = aim_enemy()
	
func aim_enemy() -> bool:
	if !enemy_body:
		return false
	
	var angle = (enemy_body.global_position - char_body.global_position).angle()
	weapon_sprite.flip_v = abs(rad_to_deg(angle)) > 90
	weapon_pivot.look_at(enemy_body.global_position + Vector2(0, -16))
	
	return true

func shoot_bullet(has_enemy: bool) -> void:
	if !has_enemy:
		return
	
	weapon_sprite.stop()
	weapon_sprite.play("bot_weapon_fire")
	
	var bullet_scene = load("res://scenes/characters/bots/bot_bullet.tscn")
	if bullet_scene == null:
		return
	
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	shooting_point.add_child(new_bullet)

func _on_bot_attack_range_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	has_enemy = false
	
	if !body is CharacterBody2D:
		return
	transitioned.emit(self, "follow", body)

func _on_attack_interval_timeout() -> void:
		shoot_bullet(has_enemy)

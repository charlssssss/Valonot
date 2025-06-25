extends Node2D

@export var game_over_screen: CanvasLayer
@export var mob_spawn_point: PathFollow2D
@export var max_bot: int = 100
var bot_counter: int = 0

func spawn_bot() -> void:
	const BOT = preload("res://scenes/characters/bots/bot.tscn")
	var new_mob = BOT.instantiate()
	
	mob_spawn_point.progress_ratio = randf()
	new_mob.global_position = mob_spawn_point.global_position
	add_child(new_mob)
	bot_counter += 1

func _on_bot_spawn_interval_timeout() -> void:
	if bot_counter <= max_bot:
		spawn_bot()

func _on_jett_game_over() -> void:
	get_tree().paused = true
	game_over_screen.visible = true

func _on_play_again_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

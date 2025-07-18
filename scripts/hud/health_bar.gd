extends ProgressBar

@onready var damage_timer: Timer = %damage_timer
@onready var damage_bar: ProgressBar = %damage_bar

var health = 0: set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
		
	if health < prev_health:
		damage_timer.start()
	elif health > prev_health:
		damage_bar.value = health

func init_health(_health) -> void:
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health


func _on_damage_timer_timeout():
	damage_bar.value = health

extends Area2D

signal hall_just_atacked
var old_health = 100
var new_health
func _process(delta: float) -> void:
	new_health = PlayerVariables.hall_health
	if old_health != new_health:
		hall_just_atacked.emit()
	old_health = new_health

func _on_hall_just_atacked() -> void:
	if PlayerVariables.hall_health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

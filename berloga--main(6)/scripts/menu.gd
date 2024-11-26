extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()

#func _ready() -> void:
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

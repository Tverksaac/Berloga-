extends Node

@onready var pause: Panel = $"../player/Camera2D/CanvasLayer/Control/pp"
var pause_b = false

func _process(delta: float) -> void:
		if Input.is_action_just_pressed("esc"):
			pause_b = !pause_b
		if pause_b == true:
			get_tree().paused = true
			pause.show()
			Engine.time_scale = 0
			
		else:
			get_tree().paused = false
			pause.hide()
			Engine.time_scale = 1
			
			
			
			
func _on_start_pressed() -> void:
	pause_b = !pause_b
	Engine.time_scale = 1

	
		
	
func _on_pause_pressed() -> void:
	pause_b = true
	Engine.time_scale = 0	


func _on_quit_pressed() -> void:
	pause_b = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
	

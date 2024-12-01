extends Node

@onready var pause: Panel = $"../player/Camera2D/CanvasLayer/Control/pp"
var GV = GlobalVariables
var pa_panel = false

func _process(delta: float) -> void:
		if Input.is_action_just_pressed("esc"):
			GV.paus = !GV.paus
			pa_panel = !pa_panel
		if GV.paus == true:
			if pa_panel: pause.show()
			get_tree().paused = true
			Engine.time_scale = 0
			
		else:
			get_tree().paused = false
			if pa_panel == false:  pause.hide()
			Engine.time_scale = 1
			
			
			
			
func _on_start_pressed() -> void:
	GV.paus = !GV.paus
	pa_panel = !pa_panel
	Engine.time_scale = 1

	
		
	
func _on_pause_pressed() -> void:
	GV.paus = true
	pa_panel = true
	Engine.time_scale = 0	


func _on_quit_pressed() -> void:
	GV.paus = false
	pa_panel = false
	GlobalVariables.ResetGame(1000)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
	

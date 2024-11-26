extends Control

func _process(delta: float) -> void:
	if GlobalVariables.clearlvl1 == true:
		$lvl2.disabled = false
	if GlobalVariables.clearlvl2 == true:
		$lvl3.disabled = false
		


func _on_lvl_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_lvl_2_pressed() -> void:
	if GlobalVariables.clearlvl1 == true:
		get_tree().change_scene_to_file("res://scenes/main2.tscn")
	
func _on_lvl_3_pressed() -> void:
	if GlobalVariables.clearlvl2 == true:
		get_tree().change_scene_to_file("res://scenes/main3.tscn")

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

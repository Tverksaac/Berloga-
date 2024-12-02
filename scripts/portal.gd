extends Area2D
signal level_changed

var flag = false



func _process(_delta: float) -> void:
	if flag:
		$Label.show()
	else:
		$Label.hide()	
	if Input.is_action_just_pressed("ui_choise") and flag == true:
		if  GlobalVariables.Task_com == true:
			get_tree().change_scene_to_file("res://scenes/main2.tscn")
			level_changed.emit()
			
				
				
				
				
			
	if Input.is_action_just_pressed("ui_choise") and flag == true:
		if GlobalVariables.Task_com == false and GlobalVariables.counter_scene == 2:
			get_tree().change_scene_to_file("res://scenes/main3.tscn")
			level_changed.emit()
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		flag = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		flag = false

func _on_level_changed() -> void:
	GlobalVariables.ResetGame(1000)
	GlobalVariables.counter_scene += 1

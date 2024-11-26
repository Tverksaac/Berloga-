extends Area2D

var flag = false


func _process(delta: float) -> void:
	if flag:
		$Label.show()
	else:
		$Label.hide()	
	if Input.is_action_just_pressed("ui_choise") and flag == true:
		if  PlayerVariables.honey >= 200 and len(GlobalVariables.busy_fabrics) == 2:
			get_tree().change_scene_to_file("res://scenes/main2.tscn")
			GlobalVariables.clearlvl1 = true
			PlayerVariables.honey = 200
			if PlayerVariables.honey >= 600 and len(GlobalVariables.busy_fabrics) == 3:
				GlobalVariables.clearlvl2 = true
				
				
				
				
			
	if Input.is_action_just_pressed("ui_choise") and flag == true:
		if PlayerVariables.honey >= 600 and GlobalVariables.clearlvl2 == true and len(GlobalVariables.busy_fabrics) == 3:
			get_tree().change_scene_to_file("res://scenes/main3.tscn")
			PlayerVariables.honey = 200
	
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		flag = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		flag = false
		
	

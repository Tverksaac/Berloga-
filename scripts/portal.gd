extends Area2D
signal level_changed

var flag = false

@onready var tasks_done_label: Label = $"../player/Camera2D/CanvasLayer/Control/Tasks/Label"

func _process(_delta: float) -> void:
	if flag:
		$Label.show()
	else:
		$Label.hide()	
	if Input.is_action_just_pressed("ui_choise") and flag == true:
		if  GlobalVariables.Task_com1 == true:
			get_tree().change_scene_to_file("res://scenes/main2.tscn")
			level_changed.emit()
			GlobalVariables.clearlvl1 = true
			if PlayerVariables.honey >= 600 and len(GlobalVariables.busy_fabrics) >= 3:
				GlobalVariables.clearlvl2 = true
				
				
				
				
			
	if Input.is_action_just_pressed("ui_choise") and flag == true:
		if PlayerVariables.honey >= 600 and GlobalVariables.clearlvl2 == true and len(GlobalVariables.busy_fabrics) >= 3:
			get_tree().change_scene_to_file("res://scenes/main3.tscn")
			level_changed.emit()
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		flag = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		flag = false

func _on_level_changed() -> void:
	for bear in GlobalVariables.bears:
		bear.queue_free()
	PlayerVariables.ChangeMoneyTo(1000)
	GlobalVariables.ClearArrays()
	GlobalVariables.task1 = false
	GlobalVariables.task2 = false
	GlobalVariables.task3 = false

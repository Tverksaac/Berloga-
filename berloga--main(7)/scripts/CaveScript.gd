extends Node2D
@onready var label: Label = $Label

var flag = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text = "Нажмите E чтобы разморозить медведя-рабочего, R - для медведя-инженера" + "(" + str(GlobalVariables.unfreeze_cost) + "$)"
	if Input.is_action_just_pressed("unfreeze_worker") and flag:
		GlobalVariables.UnfreezeBear("worker")
	if Input.is_action_just_pressed("unfreeze_electro") and flag:
		GlobalVariables.UnfreezeBear("electro")
	
	if flag == true:
		$Label.show()
	else:
		$Label.hide()
		
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		flag = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		flag = false

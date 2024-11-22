extends Node2D
@onready var label: Label = $Label

var flag = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text = "Нажмите F чтобы разморозить медведя" + "(" + str(GlobalVariables.unfreeze_cost) + "$)"
	if Input.is_action_just_pressed("ui_choise") and flag:
		GlobalVariables.UnfreezeBear()
	
	
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

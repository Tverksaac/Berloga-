extends Sprite2D
@onready var label: Label = $Label
var hint_label = false


func _ready() -> void:
	pass 
	
func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		hint_label = true

func _on_collision_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		hint_label = false

func _process(_delta: float) -> void:
	if hint_label:
		label.show()
	else:
		label.hide()
	if Input.is_action_just_pressed("ui_choise") and hint_label:
		GlobalVariables.UnfreezeBear()

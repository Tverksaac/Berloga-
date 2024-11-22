extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

var flag = false
var flag2 = false



func _on_area_2d_body_entered(body: Node2D) -> void:
	print(1)
	if body.name == "player":
		anim.play("idle")

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == 'player':
		flag = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		anim.play("hiding")

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == 'player':
		flag = false
		flag2 = false
		
func _process(_delta: float) -> void:
	if flag:
		$Label.show()
	else:
		$Label.hide()
	if flag2:
		$"../player/Camera2D/Control/BuildingList".show()
	else:
		$"../player/Camera2D/Control/BuildingList".hide()
		
	if Input.is_action_just_pressed("ui_choise") and flag:
		flag2 = true
	

	move_and_slide()



# Replace with function body.

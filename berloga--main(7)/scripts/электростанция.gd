extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_entered.connect(func ():
		GlobalVariables.free_electro.append(self)
	)

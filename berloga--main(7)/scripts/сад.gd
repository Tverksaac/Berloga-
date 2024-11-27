extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_entered.connect(func ():
		GlobalVariables.free_fabrics.append(self)
	)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

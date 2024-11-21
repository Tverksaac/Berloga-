extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tree_entered.connect(func ():
		PlayerVariables.income += 10
	)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

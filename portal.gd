extends Sprite2D

var BUG_ENEMY = preload("res://scenes/Enemies/BugEnemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while true:
		await get_tree().create_timer(2).timeout
		var current_enemy = BUG_ENEMY.instantiate()
		add_child(current_enemy)
		current_enemy.reparent(get_parent())
		print("summoned")
		

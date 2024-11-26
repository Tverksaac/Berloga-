extends Node

var bears : int
var busy_bears : Array = []
var free_bears : Array = []
var bear_cost : int

var unfreeze_cost = 50

var free_fabrics = []
var busy_fabrics = []

var clearlvl1 = false
var clearlvl2 = false

func UnfreezeBear():
	if PlayerVariables.honey < unfreeze_cost: return
	
	var bear_scene = load("res://scenes/bear.tscn")
	if bear_scene:
		var bear : CharacterBody2D = bear_scene.instantiate()
		add_child(bear)
		free_bears.append(bear)
		bear.position = Vector2(115,0)
		PlayerVariables.ChangeMoney(-unfreeze_cost)
		unfreeze_cost += 25
		print("новая цена:" + str(unfreeze_cost))

func _process(delta: float) -> void:
	PlayerVariables.income = busy_fabrics.size() * 10

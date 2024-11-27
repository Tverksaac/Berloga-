extends Node

var bears : Array = []
var busy_bears : Array = []
var free_bears : Array = []
var bear_cost : int

var electro_bears : Array = []
var busy_electro_bears : Array = []
var free_electro_bears : Array = []


var unfreeze_cost = 50

var free_fabrics = []
var busy_fabrics = []

var free_electro = []
var busy_electro = []

var clearlvl1 = false
var clearlvl2 = false

func UnfreezeBear(type):
	if PlayerVariables.honey < unfreeze_cost: return
	
	var bear_scene
	if type == "electro":
		bear_scene = load("res://scenes/electro_bear.tscn")
	elif type == "worker":
		bear_scene = load("res://scenes/bear.tscn")
		
	if bear_scene:
		var bear : CharacterBody2D = bear_scene.instantiate()
		add_child(bear)
		bears.append(bear)
		free_bears.append(bear)
		bear.position = Vector2(115,0)
		PlayerVariables.ChangeMoney(-unfreeze_cost)
		unfreeze_cost += 25
		print("новая цена:" + str(unfreeze_cost))

func _process(delta: float) -> void:
	PlayerVariables.income = 0
	PlayerVariables.electro_income = busy_electro.size() * 10
	for fabric in GlobalVariables.busy_fabrics:
		if fabric.find_child("Сад"):
			PlayerVariables.income += 5
		elif fabric.find_child("Фабрика"):
			if PlayerVariables.electro_income >= 10:
				PlayerVariables.electro_income -= 10
				PlayerVariables.income += 10


	

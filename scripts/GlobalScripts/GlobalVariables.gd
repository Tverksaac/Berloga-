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

var counter_scene = 1
var Task_com = false
var task1 = false
var task2 = false
var task3 = false

var paus

func ClearArrays():
	for cur_bear in bears:
		cur_bear.queue_free()
	bears = []
	busy_bears = []
	free_bears = []
	
	electro_bears = []
	busy_electro_bears = []
	free_electro_bears = []
	unfreeze_cost = 50
	
	free_fabrics = []
	busy_fabrics = []
	
	free_electro = []
	busy_electro = []

func StopTime():
	Engine.time_scale = 0
	
func ResumeTime():
	Engine.time_scale = 1

func ResetGame(money):
	for bear in GlobalVariables.bears:
		bear.queue_free()
	PlayerVariables.ChangeMoneyTo(money)
	GlobalVariables.ClearArrays()
	GlobalVariables.task1 = false
	GlobalVariables.task2 = false
	GlobalVariables.task3 = false
	
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

func _process(_delta):
	var memory = []
	PlayerVariables.income = 0
	PlayerVariables.electro_income = busy_electro.size() * 10
	if get_tree():
		for fabric in GlobalVariables.busy_fabrics:
			if fabric.find_child("Сад"):
				PlayerVariables.income += 10
			elif fabric.find_child("Фабрика"):
				if PlayerVariables.electro_income >= 5:
					PlayerVariables.electro_income -= 5
					PlayerVariables.income += 50
					

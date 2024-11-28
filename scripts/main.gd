extends Node2D

var BUILDINGS = {
	"Ратуша": {
		icon = preload("res://sprites/BuildingsPNG/Hall.png"),
		foreshadow_icon = preload("res://sprites/ForeshadowPNG/HallFore.png"),
		foreshadowUN_icon = preload("res://sprites/ForeshadowPNG/HallForeUN.png"),
		cost = 0,
		description = "Сердце нашего поселения"
	},
	"Фабрика": {
		icon = preload("res://sprites/BuildingsPNG/HoneyB.png"),
		foreshadow_icon = preload("res://sprites/ForeshadowPNG/HoneyBFore.png"),
		foreshadowUN_icon = preload("res://sprites/ForeshadowPNG/HoneyBForeUN.png"),
		cost = 100,
		description = "Медовая фабрика, на которой наши медведи будут пасти пчёл. Нужно быть осторожней, если фабрик будет слишком много, медведи могут взбунтоваться"
	},
	"Сад": {
		icon = preload("res://sprites/BuildingsPNG/HoneyGarden.png"),
		foreshadow_icon = preload("res://sprites/ForeshadowPNG/HoneyGardenFore.png"),
		foreshadowUN_icon = preload("res://sprites/ForeshadowPNG/HoneyGardenForeUN.png"),
		cost = 50
	},
	"Электростанция": {
		icon = preload("res://sprites/BuildingsPNG/Electro.png"),
		foreshadow_icon = preload("res://sprites/ForeshadowPNG/ElectroFore.png"),
		foreshadowUN_icon =  preload("res://sprites/ForeshadowPNG/ElectroForeUN.png"),
		cost = 175
	}
}

@onready var label: Label = $player/Camera2D/CanvasLayer/Control/Pan_MED/MED
@onready var label_en: Label = $player/Camera2D/CanvasLayer/Control/PAN_ELEC/ELEC
@onready var main: Node2D = $"."
@onready var building_list: ItemList = $player/Camera2D/CanvasLayer/Control/BuildingList
@onready var player: CharacterBody2D = $player
@onready var buildings_node: Node2D = $buildings
@onready var pause: Panel = $player/Camera2D/CanvasLayer/Control/pp

@onready var test1: Label = $player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n1/MED
@onready var test_is1: Label = $player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n1/MED2
@onready var test2: Label = $player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n2/MED
@onready var test_is2: Label = $player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n2/MED2
@onready var test3: Label = $player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n3/MED
@onready var test_is3: Label = $player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n3/MED2

var placing_building = false
var current_building : Area2D = null
var building_sprite : Sprite2D = null
var building_path = null
var building_name : String = ""
var building_cost : int
var building_num

var current_honey

const PLACE_POS = 1

func DeselectBuilding():
	current_building.queue_free()
	placing_building = false
	current_building = null
	building_sprite = null
	building_path = null
	building_name = ""

func _ready() -> void:
	building_list.item_selected.connect(func(buildNum):
		building_num = buildNum
		print(building_num)
		if placing_building:
			DeselectBuilding()
			
		building_name = building_list.get_item_text(buildNum).split(" ")[0]
		print(building_name)
		var scene = load("res://scenes/".path_join(building_name) + ".tscn")
		if scene:
			var building = scene.instantiate()
			add_child(building)
			current_building = building
			building = null
			placing_building = true
			building_sprite  = current_building.get_node("Sprite2D")
			#building_name = building_list.get_item_text(buildNum)
			building_path = BUILDINGS[building_name]
			building_cost = BUILDINGS[building_name].cost
	)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	PlayerVariables.UpdateMoney(label)
	PlayerVariables.UpdateEnergy(label_en)
	PlayerVariables.UpdateMoney(test1)
	test2.text = str(len(GlobalVariables.busy_fabrics))
	test3.text = str(len(GlobalVariables.bears) + len(GlobalVariables.electro_bears))
	if  PlayerVariables.honey >= int(test_is1.text):
		$player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n1.hide()
		GlobalVariables.task1 = true
	if len(GlobalVariables.busy_fabrics) == int(test_is2.text):
		$player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n2.hide()
		GlobalVariables.task2 = true
	if len(GlobalVariables.bears) + len(GlobalVariables.electro_bears) == int(test_is3.text):
		$player/Camera2D/CanvasLayer/Control/Tasks/VBoxContainer/n3.hide()
		GlobalVariables.task3 = true
	if GlobalVariables.task1 and GlobalVariables.task2 and GlobalVariables.task3:
		GlobalVariables.Task_com1 = true
		$player/Camera2D/CanvasLayer/Control/Tasks/Label.show()
	
	
	if placing_building and current_building:
		var is_empty = current_building.get_overlapping_areas().is_empty()
		var mouse_pos = get_global_mouse_position()
		
		var is_able_to_place = func ():
			if is_empty and PlayerVariables.honey >= building_cost:
				return true
			else:
				return false


		current_building.position.x = mouse_pos.x
		current_building.position.y = PLACE_POS


		if is_able_to_place.call():
			building_sprite.texture = building_path.foreshadow_icon
		else:
			building_sprite.texture = building_path.foreshadowUN_icon
			
		if Input.is_action_just_pressed("place_building") and is_able_to_place.call():
			building_sprite.texture = building_path.icon
			current_building.reparent(buildings_node.find_child(building_name))
			current_building = null
			placing_building = false
			building_list.deselect_all()
			PlayerVariables.ChangeMoney(-building_cost)
			if building_name != "Электростанция":
				building_path.cost *= 1.5
				print("Новая цена:" + str(int(building_cost * 1.5)))
				building_list.set_item_text(building_num, building_name + " " + str(int(building_cost * 1.5)))
			
		elif Input.is_action_just_pressed("place_building") and not is_able_to_place.call():
			DeselectBuilding()
			building_list.deselect_all()

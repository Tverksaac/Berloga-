extends Node2D

var BUILDINGS = {
	"Ратуша": {
		icon = preload("res://sprites/BuildingsPNG/Hall.png"),
		foreshadow_icon = preload("res://sprites/ForeshadowPNG/HallFore.png"),
		foreshadowUN_icon = preload("res://sprites/ForeshadowPNG/HallForeUN.png"),
		cost = 0
	},
	"Фабрика": {
		icon = preload("res://sprites/BuildingsPNG/HoneyB.png"),
		foreshadow_icon = preload("res://sprites/ForeshadowPNG/HoneyBFore.png"),
		foreshadowUN_icon = preload("res://sprites/ForeshadowPNG/HoneyBForeUN.png"),
		cost = 100
	}
}


@onready var label: Label = $player/Camera2D/Control/Panel/Label
@onready var main: Node2D = $"."
@onready var building_list: ItemList = $player/Camera2D/Control/BuildingList
@onready var player: CharacterBody2D = $player
@onready var buildings_node: Node2D = $buildings

var placing_building = false
var current_building : Area2D = null
var building_sprite : Sprite2D = null
var building_path = null
var building_name : String = ""
var building_cost : int

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
		if placing_building:
			DeselectBuilding()
			
		var scene = load("res://scenes/".path_join(building_list.get_item_text(buildNum)) + ".tscn")
		if scene:
			var building = scene.instantiate()
			add_child(building)
			current_building = building
			building = null
			placing_building = true
			building_sprite  = current_building.get_node("Sprite2D")
			building_name = building_list.get_item_text(buildNum)
			building_path = BUILDINGS[building_list.get_item_text(buildNum)]
			building_cost = BUILDINGS[building_name].cost
	)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	PlayerVariables.UpdateMoney(label)
	
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
			building_path.cost *= 1.5
			current_building = null
			placing_building = false
			building_list.deselect_all()
			PlayerVariables.ChangeMoney(-building_cost)
			
		elif Input.is_action_just_pressed("place_building") and not is_able_to_place.call():
			DeselectBuilding()
			building_list.deselect_all()

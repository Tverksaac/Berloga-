extends Node2D

const BUILDINGS = {
	"Hall": {
		icon = preload("res://sprites/BuildingsPNG/Hall.png"),
		foreshadow_icon = preload("res://sprites/ForeshadowPNG/HallFore.png"),
		foreshadowUN_icon = preload("res://sprites/ForeshadowPNG/HallForeUN.png")
	}
}

@onready var main: Node2D = $"."
@onready var building_list: ItemList = $CharacterBody2D/Camera2D/Control/BuildingList

var placing_building = false
var current_building : Area2D = null
var building_sprite : Sprite2D = null

	# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		building_list.item_selected.connect(func(buildNum):
			var scene = load("res://scenes/".path_join(building_list.get_item_text(buildNum)) + ".tscn")
			var building = scene.instantiate()
			add_child(building)
			current_building = building
			placing_building = true
			building_sprite  = current_building.get_node("Sprite2D")
			)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if placing_building and current_building:
		var is_empty = current_building.get_overlapping_areas().is_empty()
		var mouse_pos = get_global_mouse_position()
		current_building.position.x = mouse_pos.x
		if is_empty:
			building_sprite.texture = BUILDINGS.Hall.foreshadow_icon
		else:
			building_sprite.texture = BUILDINGS.Hall.foreshadowUN_icon
		if Input.is_action_just_pressed("place_building"):
			if is_empty:
				placing_building = false
				current_building = null
				building_sprite.texture = BUILDINGS.Hall.icon
				building_list.deselect_all()
		

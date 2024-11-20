extends Node2D
@onready var buildings: Node2D = $"."
@onready var label: Label = $"../player/Camera2D/Control/Panel/Label"
@onready var fabrics_node: Node2D = $"Фабрика"
@onready var halls_node: Node2D = $"Ратуша"
@onready var player: CharacterBody2D = $"../player"

var fabrics_count
var income : int = 0

#await get_tree().create_timer(1).timeout
func _ready():
	pass

func _process(_delta: float) -> void:
	pass

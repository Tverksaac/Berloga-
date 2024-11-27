extends Node2D
@onready var buildings: Node2D = $"."
@onready var fabrics_node: Node2D = $"Фабрика"
@onready var halls_node: Node2D = $"Ратуша"
@onready var player: CharacterBody2D = $"../player"

var fabrics_count = 0
var income : int = 0

#await get_tree().create_timer(1).timeout
func _ready():
	
	while PlayerVariables.is_income:
		await get_tree().create_timer(1).timeout
		PlayerVariables.ChangeMoney(PlayerVariables.income * PlayerVariables.income_modifer)

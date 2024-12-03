extends Area2D

@onready var timer_label: Label = $"../player/Camera2D/CanvasLayer/Control/Timer/TimerLabel"
const PORTAL = preload("res://scenes/Enemies/portal.tscn")

var strenth_scale = 1

func GetTime():
	var arr = timer_label.text.split(":")
	return arr
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

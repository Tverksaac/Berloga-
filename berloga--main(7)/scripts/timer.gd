extends Panel

var game_time = 0

@onready var timer_label: Label = $TimerLabel



func Timer():
	while true:
		await get_tree().create_timer(1).timeout
		game_time += 1
		var minutes = int(game_time / 60)
		var seconds = game_time % 60
		if seconds < 10:
			seconds = "0" + str(seconds)
		timer_label.text = str(minutes) + ":" + str(seconds)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

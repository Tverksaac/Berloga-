extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var health = 100

func WalkTo(pos):
	var dir_to_walk
	if self.position.x > pos.x:
		dir_to_walk = -1
	elif self.position.x < pos.x:
		dir_to_walk = 1
	elif self.position.x == pos.x:
		dir_to_walk = 1
	if dir_to_walk == 1:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	while true:
		await get_tree().create_timer(0.01).timeout
		velocity.x = 1 * 100
		move_and_slide()
		if self.position.distance_to(pos) < 10:
			break

func Atack():
	while self:
		await get_tree().create_timer(1).timeout
		PlayerVariables.hall_health -= 2
		

func _on_atack_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("M1"):
		TakeDamage()
	
func TakeDamage():
	var Clicked_tween = get_tree().create_tween()
	var Returning_tween = get_tree().create_tween()
	Clicked_tween.tween_property(animated_sprite_2d, "global_scale", Vector2(5, 5), 0.2)
	Returning_tween.tween_property(animated_sprite_2d, "global_scale", Vector2(1, 1),  0.2)
	Clicked_tween.play()
	await Clicked_tween.finished
	Returning_tween.play()
	
	health -= PlayerVariables.click_power
	if health <= 0 :
		queue_free()





func _ready() -> void:
	await WalkTo(Vector2(0,0))
	Atack()

func _process(delta: float) -> void:
	pass

extends CharacterBody2D

var GB = GlobalVariables
var is_busy = false
var fabric
var direction = 1

func HandleAnims():
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play()
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.pause()

func IsFabricAvaliable():
	if GB.free_fabrics.size() != 0:
		return true
	else:
		return false

func WalkTo(pos):
	var dir_to_walk
	if self.position.x > pos.x:
		dir_to_walk = -1
	elif self.position.x < pos.x:
		dir_to_walk = 1

	while true:
		await get_tree().create_timer(0.01).timeout
		velocity.x = dir_to_walk * 100
		move_and_slide()
		if self.position.distance_to(pos) < 10:
			return

func GoToWork():
	fabric = GB.free_fabrics[0]
	GB.busy_fabrics.append(GB.free_fabrics[0])
	GB.free_fabrics.remove_at(0)
	GB.free_bears.erase(self)
	GB.busy_bears.append(self)
	is_busy = true
	print("goint to work...")
	WalkTo(fabric.position)

func WalkAround():
	velocity.x = direction * randi_range(50, 75)
	move_and_slide()
	
	
func _ready() -> void:
	
	while is_busy == false:
		await get_tree().create_timer(2).timeout
		direction = randi_range(-1, 1)
		
func _process(delta: float) -> void:
	if IsFabricAvaliable() and is_busy == false:
		for fabric in GlobalVariables.free_fabrics:
			if fabric.find_child("Сад"):
				GoToWork()
			elif fabric.find_child("Фабрика") and PlayerVariables.electro_income > 0:
				GoToWork() 
			else:
				WalkAround()
				
	if IsFabricAvaliable() == false and is_busy == false:
		WalkAround()

	
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
	for found_fabric in GB.free_fabrics:
		if found_fabric.find_child("Сад"):
			return true
		elif found_fabric.find_child("Фабрика") and PlayerVariables.electro_income >= 5:
			return true
		else:
			continue
		if GB.free_fabrics.size() == 0:
			continue
	return false


func IsWorking():
	if GB.busy_bears.find(self) == -1:
		return false
	else:
		return true

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

func GoToWork(fabric_name):
	for free_fabric in GB.free_fabrics:
		if fabric_name == "Фабрика" and PlayerVariables.electro_income < 5: continue
		if free_fabric.find_child(fabric_name):
			fabric = free_fabric
			break
	GB.free_fabrics.remove_at(GB.free_fabrics.find(fabric))
	GB.busy_fabrics.append(fabric)
	GB.free_bears.erase(self)
	GB.busy_bears.append(self)
	WalkTo(fabric.position)

func WalkAround():
	velocity.x = direction * randi_range(60, 75)
	move_and_slide()
	
	
func _ready() -> void:
	
	while is_busy == false:
		await get_tree().create_timer(2).timeout
		direction = randi_range(-1, 1)
		
func _process(delta: float) -> void:
	var memory = []
	if IsFabricAvaliable() == true and IsWorking() == false:
		
		
				
		for current_fabric in GlobalVariables.free_fabrics:

			if self in memory:
				continue
			
			print(current_fabric)
			if current_fabric.find_child("Сад"):
				GoToWork("Сад")
				memory.append(self)
			elif current_fabric.find_child("Фабрика") and PlayerVariables.electro_income >= 5:
				GoToWork("Фабрика")
				memory.append(self)
				
	if IsFabricAvaliable() == false and IsWorking() == false:
		WalkAround()

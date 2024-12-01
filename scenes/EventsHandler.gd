extends ColorRect

@onready var main_body: ColorRect = $"."
@onready var text_body: ColorRect = $TextBody
@onready var dialog_label: Label = $DialogLabel
@onready var speeker_img: TextureRect = $SpeekerImg
@onready var speeker_name: Label = $SpeekerName
@onready var choose_button_1: Button = $Choose1
@onready var choose_button_2: Button = $Choose2
@onready var inf1: Label = $Choose1/INF1
@onready var inf2: Label = $Choose2/INF2

@onready var timer_label: Label = $"../Timer/TimerLabel"

var PV = PlayerVariables
var GV = GlobalVariables

var current_event
var memory

var paus = false

func EndEvent():
	main_body.hide()
	GV.ResumeTime()

func GetTime():
	var arr = timer_label.text.split(":")
	return arr



##шаблон для ивента:
#event = {
	#speeker = {
		#name = имя,
		#image = картинка,
		#text = текст,
	#},
	#event = {
		#event_name = имя_ивента,
		#choose_1 = текст_выбора_1,
		#choose_2 = текст_выбора_2,
		#callback_1 = ФункцияПриПервомВыборе,
		#callback_2 = ФункцияПриВторомВыборе
	#}}

var EVENTS_LIST = {
	event0 = {
		speeker = {
			name = "Григорий",
			image = "ВСТАВИТЬ КАРТИНКУ",
			text = "ЗДАРОВА МЕДВЕДИ БУНТУЮТ МЫ ВАЩЕ ХЗ ЧТО ДЕЛАТЬ ААААААААААААААААА СПАСИ"
		},
		event = {
			event_name = "Медвежий бунт",
			choose_1 = "Помиловать!",
			choose_2 = "Казнить!",
			result_1 = "-75 мёда/сек, 1.2 множитель производства",
			result_2 = "-200 мёда",
			callback_1 = TestEventCall1,
			callback_2 = TestEventCall2,
			condition = TestEventCond
		}},
}

func ChooseEvent():
	var event_num = randi_range(0, EVENTS_LIST.size() - 1)
	var choosen_event : Dictionary = EVENTS_LIST["event" + str(event_num)]
	if EVENTS_LIST.size() == len(memory):
		return false
	elif choosen_event in memory:
		ChooseEvent()
	else:
		memory.append(choosen_event)
	if choosen_event.event.condition.call():
		return choosen_event
	else:
		ChooseEvent()

func TestEventCond():
	if PV.income >= 80:
		return true
	else:
		return false
		
func TestEventCall1():
	print("Ивент сработал!! 1")
func TestEventCall2():
	print("Ивент сработал!! 2")
			

func _on_choose_1_pressed() -> void:
	current_event.event.callback_1.call()
	GV.paus = false
	EndEvent()


func _on_choose_2_pressed() -> void:
	current_event.event.callback_2.call()
	GV.paus = false
	EndEvent()
	
	
func _ready() -> void:
	while true:
		await get_tree().create_timer(1).timeout
		var seconds = int(GetTime()[1])
		var minutes = int(GetTime()[0])
		if seconds == 00 or seconds == 10:
			print("Щас ивент будет!")
			memory = []
			current_event = ChooseEvent()
			if current_event:
				main_body.show()
				GV.paus = true
				print("TIME SCALED TO 0")
				choose_button_1.text = current_event.event.choose_1
				choose_button_2.text = current_event.event.choose_2
				dialog_label.text = current_event.speeker.text
				speeker_name.text = current_event.speeker.name
				inf1.text = current_event.event.result_1
				inf2.text = current_event.event.result_2



func _on_choose_1_mouse_entered() -> void:
	inf1.show()

func _on_choose_1_mouse_exited() -> void:
	inf1.hide()

func _on_choose_2_mouse_entered() -> void:
	inf2.show()

func _on_choose_2_mouse_exited() -> void:
	inf2.hide()

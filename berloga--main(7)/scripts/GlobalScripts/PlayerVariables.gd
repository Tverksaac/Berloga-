extends Node

var honey = 100000
var income = 0
var is_income = true
var income_modifer = 1

var electro_income = 0

var hall_health = 100

var click_power = 10

func ChangeMoney(value):
	honey += value
	
func UpdateMoney(node):
	node.text = str(honey)

func ChangeMoneyTo(value):
	honey = value

extends Node

var honey = 200
var income = 0
var lose = 0
var is_income = true
var income_modifer = 1

func ChangeMoney(value):
	honey += value
	
func UpdateMoney(node):
	node.text = str(honey)

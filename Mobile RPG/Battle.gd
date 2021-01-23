extends Node

onready var enemy = $Enemy
onready var battleActionButton = $UI/BattleActionButton

func _on_SwordButton_pressed():
	
	if enemy!=null:
		enemy.hp -= 4


func _on_Enemy_died():
	battleActionButton.hide()
	enemy= null

extends Node

onready var enemy = $Enemy #inizializzata dopo la chiamata a ready

func _on_SwordButton_pressed():
	enemy.hp -= 4

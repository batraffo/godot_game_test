extends Node

onready var hplabel = $Enemy/HPLabel #inizializzata dopo la chiamata a ready

func _on_SwordButton_pressed():
	hplabel.text=str(hplabel.text.substr(0,2).to_int() -3 ) + "hp"

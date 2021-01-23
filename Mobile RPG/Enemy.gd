extends Node2D

var hp = 25 setget set_hp #chiamata quando cambio la variabile

onready var hpLabel=$HPLabel
onready var animationPlayer = $AnimationPlayer

signal died

func set_hp(new_hp):
	hp=new_hp
	hpLabel.text= str(hp)+"hp"
	
	if hp<= 0:
		emit_signal("died")
		queue_free()
	else:
		animationPlayer.play("Shake")
		yield(animationPlayer,"animation_finished") #mi serve per altri progetti
		animationPlayer.play("Attack")
		yield(animationPlayer, "animation_finished")
		var battle=get_tree().current_scene
		var player = battle.find_node("PlayerStats")
		player.hp -=3

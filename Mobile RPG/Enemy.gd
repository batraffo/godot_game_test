extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

export (int) var hp = 25 setget set_hp #chiamata quando cambio la variabile
export (int) var damage = 3

onready var hpLabel=$HPLabel
onready var animationPlayer = $AnimationPlayer

signal died
signal end_turn

func set_hp(new_hp):
	hp=new_hp
	if(hpLabel!=null):
		hpLabel.text= str(hp)+"hp"
	
func _ready():
	BattleUnits.Enemy=self
	
func _exit_tree():
	BattleUnits.Enemy = null

func attack() -> void:
	yield(get_tree().create_timer(0.4), "timeout")#aspetto un quarto di secondo per nonfar attccare come finisce l'animazione di shake
	animationPlayer.play("Attack")
	
	yield(animationPlayer, "animation_finished") #verrà chiamta dealdamage durante l'animazione

	emit_signal("end_turn")
	

func deal_damage(): #i danni verranno segnati durante l'animazione non all'inizio
	BattleUnits.PlayerStats.hp -=damage
	print("dealed")

func take_damage(amount):
	self.hp -=amount
	if is_dead():
		queue_free()
		emit_signal("died")
	else:
		animationPlayer.play("Shake")

func is_dead():
	return hp<=0

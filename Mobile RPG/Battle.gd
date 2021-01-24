extends Node

const BattleUnits= preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = [] #array di scene di nemici

onready var battleActionButton = $UI/BattleActionButton
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition

func _ready():
	randomize()
	start_player_turn()
	var enemy= BattleUnits.Enemy
	if enemy != null:
		enemy.connect("died",self, "_on_Enemy_died")

func start_enemy_turn():
	battleActionButton.hide()
	var enemy= BattleUnits.Enemy
	if enemy!=null and not enemy.is_queued_for_deletion():
		enemy.attack()
		yield(enemy, "end_turn") #aspetto il segnale end turn del player
	start_player_turn()
	
func start_player_turn():
	var enemy= BattleUnits.Enemy
	if enemy!=null and not enemy.is_queued_for_deletion(): #se il colpo finale ha ap = 0 potrei rimostrare i comandi
		battleActionButton.show()
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap= playerStats.max_ap #rifocilliamo i punti azione del player
	yield(playerStats,"end_turn") #aspetto il segnale end turn per continuare
	start_enemy_turn()

func create_New_Enemy():
	enemies.shuffle() #mischia gli elementi dentro l'array
	var Enemy = enemies.front()
	var enemy= Enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died():
	nextRoomButton.show()
	battleActionButton.hide()

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer, "animation_finished")
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap= playerStats.max_ap
	battleActionButton.show()
	create_New_Enemy()

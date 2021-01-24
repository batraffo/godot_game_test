extends Node

const BattleUnits= preload("res://BattleUnits.tres")

onready var battleActionButton = $UI/BattleActionButton

func _ready():
	start_player_turn()

func start_enemy_turn():
	battleActionButton.hide()
	var enemy= BattleUnits.Enemy
	if enemy!=null:
		enemy.attack()
		yield(enemy, "end_turn") #aspetto il segnale end turn del nemico
	start_player_turn()
	
func start_player_turn():
	battleActionButton.show()
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap= playerStats.max_ap #rifocilliamo i punti azione del player
	yield(playerStats,"end_turn") #aspetto il segnale end turn per continuare
	start_enemy_turn()


func _on_Enemy_died():
	battleActionButton.hide()

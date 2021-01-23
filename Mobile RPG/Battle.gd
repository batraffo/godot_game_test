extends Node

onready var enemy = $Enemy
onready var playerStats = $PlayerStats
onready var battleActionButton = $UI/BattleActionButton

func _ready():
	start_player_turn()

func start_enemy_turn():
	battleActionButton.hide()
	if enemy!=null:
		enemy.attack(playerStats)
		yield(enemy, "end_turn")
	start_player_turn()
	
func start_player_turn():
	battleActionButton.show()
	playerStats.ap= playerStats.max_ap #rifocilliamo i punti azione del player
	yield(playerStats,"end_turn") #aspetto il segnale end turn per continuare
	start_enemy_turn()


func _on_Enemy_died():
	battleActionButton.hide()
	enemy= null

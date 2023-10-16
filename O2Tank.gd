extends Area2D

func _on_player_hide_o_2_tank():
	queue_free()

func _ready():
	if Globals.inventory.count("O2Tank") > 0:
		queue_free()

extends Area2D

func _ready():
	if Globals.inventory.count("Magazine") > 0:
		queue_free()

func _on_player_hide_magazine():
	queue_free()

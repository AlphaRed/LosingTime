extends Area2D

func _ready():
	if Globals.inventory.count("O2Tank") > 0:
		queue_free()

func _process(_delta):
	if Globals.inventory.count("O2Tank") > 0:
		queue_free()

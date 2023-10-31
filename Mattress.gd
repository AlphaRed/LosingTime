extends Area2D

func _ready():
	if Globals.glider_confidence == true:
		self.set_position(Vector2(0,0))
	
	if Globals.inventory.count("Mattress") > 0:
		queue_free()

func _process(_delta):
	if Globals.inventory.count("Mattress") > 0:
		queue_free()

extends Area2D

@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("idle")
	
	if Globals.glider_confidence == true:
		queue_free()

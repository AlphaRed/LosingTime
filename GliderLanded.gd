extends Area2D

@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("idle")
	
	if Globals.glider_confidence == true:
		self.set_position(Vector2(0,0))


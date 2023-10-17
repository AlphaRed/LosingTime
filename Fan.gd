extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var col = $CollisionShape2D

func _ready():
	if Globals.inventory.count("Fan") > 0:
		queue_free()

func _process(_delta):
	if Globals.drop_fan_item == true:
		sprite.visible = true
		col.set_disabled(false)
	else:
		sprite.visible = false
		col.set_disabled(true)
	
	if Globals.inventory.count("Fan") > 0:
		queue_free()

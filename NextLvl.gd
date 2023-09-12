extends Area2D

# Want to use this so I can specify the next level...should work in theory
@export var nextLevel = "level_2"

func _physics_process(_delta):
	if Input.is_action_pressed("interact"):
		pass

extends CharacterBody2D

var max_speed = 150.0
var acceleration = 100.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var target_speed = 0.0
var input = Vector2.ZERO

@onready var sprite = $AnimatedSprite2D

func get_input() -> Vector2:
	# TO DO
	# maybe cool stuff later? (coyote time, etc.)
	input = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		input.x = -1
		target_speed = max_speed
		sprite.flip_h = true # left is other than default (true)
	elif Input.is_action_pressed("right"):
		input.x = 1
		target_speed = max_speed
		sprite.flip_h = false # right is default (false)
	
	if Input.is_action_pressed("jump"):
		input.y = -1
	
	return input.normalized()

func player_movement(delta) -> void:
	input = get_input()
	
	# Horizontal movement
	velocity.x = lerp(velocity.x, (target_speed * input.x), 1)
	
	# Vertical movement...jumping!
	if input.y < 0:
		if is_on_floor():
			velocity.y = -max_speed * acceleration * delta
	
	# Apply gravity if airborne
	if !is_on_floor():
		velocity.y += gravity * delta
	
	# Set the animations
	if !is_on_floor():
		sprite.play("jump")
	elif velocity.x != 0:
		sprite.play("run")
	else:
		sprite.play("run")
		sprite.stop() # stop sets to first frame of playing anim
	
	move_and_slide()

func _physics_process(delta):
	player_movement(delta)

func _ready():
	pass

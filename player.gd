extends CharacterBody2D

var max_speed = 150
var acceleration = 1000
var friction = 800
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var input = Vector2.ZERO

func get_input() -> Vector2:
	# TO DO
	# proper jumping and falling stuff, maybe cool stuff later? (coyote time, etc.)
	input = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		input.x = -1
	elif Input.is_action_pressed("right"):
		input.x = 1
	
	if Input.is_action_pressed("jump"):
		input.y = -1
	
	return input.normalized()

func player_movement(delta) -> void:
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	
	apply_gravity(delta)
	
	move_and_slide()

func apply_gravity(delta) -> void:
	if is_on_floor():
		pass
	else:
		velocity.y += gravity * delta

func _physics_process(delta):
	player_movement(delta)

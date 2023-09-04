extends CharacterBody2D

var max_speed = 150.0
var acceleration = 100.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var target_speed = 0.0
var dir = Vector2.ZERO
var door = false
var filepath = ""

@onready var sprite = $AnimatedSprite2D
@onready var cam = $Camera2D

func get_input() -> Vector2:
	# TO DO
	# maybe cool stuff later? (coyote time, etc.)
	dir = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		dir.x = -1
		target_speed = max_speed
		sprite.flip_h = true # left is other than default (true)
	elif Input.is_action_pressed("right"):
		dir.x = 1
		target_speed = max_speed
		sprite.flip_h = false # right is default (false)
	
	if Input.is_action_pressed("jump"):
		dir.y = -1
	
	if Input.is_action_pressed("use"):
		if door == true:
			get_tree().change_scene_to_file("res://level_2.tscn")
	
	return dir.normalized()

func player_movement(delta) -> void:
	dir = get_input()
	
	# Horizontal movement
	velocity.x = lerp(velocity.x, (target_speed * dir.x), 1)
	
	# Vertical movement...jumping!
	if dir.y < 0:
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

func _on_next_lvl_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		door = true
		

func _on_next_lvl_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		door = false


func _on_boris_body_entered(_body):
	pass # Replace with function body.

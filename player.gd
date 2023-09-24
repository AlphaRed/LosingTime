extends CharacterBody2D

enum {NA, DOOR, TALK, PICKUP} # interaction enum
enum {NONE, BORIS, VENDOR, MECHANIC, BARBER, FARMER} # NPC enum

signal interact_talk(NPC_name)

var max_speed = 150.0
var acceleration = 100.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var target_speed = 0.0
var dir = Vector2.ZERO
var interact = NA
var NPC = NONE
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
	
	if Input.is_action_just_pressed("interact"): # less flickering this way
		if interact == DOOR:
			get_tree().change_scene_to_file(filepath)
		elif interact == TALK:
			if NPC == BORIS:
				interact_talk.emit(BORIS)
			elif NPC == VENDOR:
				interact_talk.emit(VENDOR)
			else:
				pass
	
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

# Next Level Methods
# Level 1
func _on_to_generator_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("Entering generator room")
		interact = DOOR
		filepath = "res://level_2.tscn"

func _on_to_generator_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("Exited generator room")
		interact = NA
		filepath = ""

func _on_to_town_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_3.tscn"

func _on_to_town_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 2
func _on_to_castle_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_1.tscn"

func _on_to_castle_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 3
func _on_to_castle_other_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_1.tscn"

func _on_to_castle_other_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_farm_from_town_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_6.tscn"

func _on_to_farm_from_town_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_garage_from_town_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_4.tscn"

func _on_to_garage_from_town_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_barber_from_town_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_5.tscn"

func _on_to_barber_from_town_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 4
# Level 5
# Level 6
# Level 7
# Level 8
# Level 9

# Talking methods
func _on_boris_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = BORIS


func _on_boris_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

func _on_vendor_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = VENDOR

func _on_vendor_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

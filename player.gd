extends CharacterBody2D

enum {NA, DOOR, TALK, PICKUP} # interaction enum
enum {NONE, BORIS, VENDOR, MECHANIC, BARBER, FARMER, GLIDER, DIVER, OSCAR} # NPC enum
enum {NO_ITEM, O2TANK, SNORKEL, MAGAZINE, FAN, MATTRESS, BELLOWS} # Item enum

signal interact_talk(NPC_name)

var max_speed = 150.0
var acceleration = 100.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var target_speed = 0.0
var dir = Vector2.ZERO
var interact = NA
var NPC = NONE
var filepath = ""
var Item = NO_ITEM

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
			elif NPC == MECHANIC:
				interact_talk.emit(MECHANIC)
			elif NPC == BARBER:
				interact_talk.emit(BARBER)
			elif NPC == FARMER:
				interact_talk.emit(FARMER)
			elif NPC == GLIDER:
				interact_talk.emit(GLIDER)
			elif NPC == DIVER:
				interact_talk.emit(DIVER)
			elif NPC == OSCAR:
				interact_talk.emit(OSCAR)
			else:
				pass
		elif interact == PICKUP:
			add_inventory(Item)
	
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
	set_position(Globals.spawnLocation)

func add_inventory(item_pickup):
	if item_pickup == O2TANK:
		Globals.inventory.append("O2Tank")
	elif item_pickup == MAGAZINE:
		Globals.inventory.append("Magazine")
	elif item_pickup == FAN:
		Globals.inventory.append("Fan")
	elif item_pickup == MATTRESS:
		Globals.inventory.append("Mattress")
	elif item_pickup == BELLOWS:
		Globals.inventory.append("Bellows")
	elif item_pickup == SNORKEL:
		Globals.inventory.append("Snorkel")

# Next Level Methods
# Level 1
func _on_to_generator_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("Entering generator room")
		interact = DOOR
		filepath = "res://level_2.tscn"
		Globals.spawnLocation = Vector2(9, 168)

func _on_to_generator_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("Exited generator room")
		interact = NA
		filepath = ""

func _on_to_town_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_3.tscn"
		Globals.spawnLocation = Vector2(10, 184)

func _on_to_town_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 2
func _on_to_castle_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_1.tscn"
		Globals.spawnLocation = Vector2(200, 168)

func _on_to_castle_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 3
func _on_to_castle_other_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_1.tscn"
		Globals.spawnLocation = Vector2(312, 200)

func _on_to_castle_other_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_farm_from_town_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_6.tscn"
		Globals.spawnLocation = Vector2(10, 184)

func _on_to_farm_from_town_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_garage_from_town_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_4.tscn"
		Globals.spawnLocation = Vector2(10, 184)

func _on_to_garage_from_town_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_barber_from_town_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_5.tscn"
		Globals.spawnLocation = Vector2(10, 184)

func _on_to_barber_from_town_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 4
func _on_to_town_from_garage_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_3.tscn"
		Globals.spawnLocation = Vector2(88, 184)

func _on_to_town_from_garage_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 5
func _on_to_town_from_barber_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_3.tscn"
		Globals.spawnLocation = Vector2(232, 184)

func _on_to_town_from_barber_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 6
func _on_to_town_from_farm_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_3.tscn"
		Globals.spawnLocation = Vector2(312, 184)

func _on_to_town_from_farm_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_cliff_from_farm_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_7.tscn"
		Globals.spawnLocation = Vector2(10, 184)

func _on_to_cliff_from_farm_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 7
func _on_to_farm_from_cliff_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_6.tscn"
		Globals.spawnLocation = Vector2(312, 184)

func _on_to_farm_from_cliff_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_pond_from_cliff_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_8.tscn"
		Globals.spawnLocation = Vector2(10, 184)

func _on_to_pond_from_cliff_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 8
func _on_to_cliff_from_pond_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_7.tscn"
		Globals.spawnLocation = Vector2(312, 184)

func _on_to_cliff_from_pond_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

func _on_to_dump_from_pond_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_9.tscn"
		Globals.spawnLocation = Vector2(10, 184)

func _on_to_dump_from_pond_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

# Level 9
func _on_to_pond_from_dump_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = DOOR
		filepath = "res://level_8.tscn"
		Globals.spawnLocation = Vector2(312, 184)

func _on_to_pond_from_dump_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		filepath = ""

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

func _on_mechanic_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = MECHANIC

func _on_mechanic_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

func _on_barber_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = BARBER

func _on_barber_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

func _on_farmer_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = FARMER

func _on_farmer_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

func _on_glider_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = GLIDER

func _on_glider_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

func _on_diver_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = DIVER

func _on_diver_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

func _on_oscar_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = OSCAR

func _on_oscar_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

func _on_glider_landed_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		print("can interact")
		interact = TALK
		NPC = GLIDER

func _on_glider_landed_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		print("cannot interact")
		interact = NA
		NPC = NONE

# Items
func _on_o_2_tank_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = PICKUP
		Item = O2TANK

func _on_o_2_tank_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		Item = NO_ITEM

func _on_magazine_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = PICKUP
		Item = MAGAZINE

func _on_magazine_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		Item = NO_ITEM

func _on_fan_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = PICKUP
		Item = FAN

func _on_fan_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		Item = NO_ITEM

func _on_mattress_body_entered(body):
	if body.is_in_group("PlayerGroup"):
		interact = PICKUP
		Item = MATTRESS

func _on_mattress_body_exited(body):
	if body.is_in_group("PlayerGroup"):
		interact = NA
		Item = NO_ITEM

func _on_dialog_box_add_item(item):
	add_inventory(item)

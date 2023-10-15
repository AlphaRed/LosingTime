extends CanvasLayer

@onready var background = $Background
@onready var textbox = $Text

enum {NONE, BORIS, VENDOR, MECHANIC, BARBER, FARMER, GLIDER, DIVER, OSCAR} # NPC enum

var Boris = "We need to fix the generator to provide power. Igor, fetch me parts to fix it!"
var Vendor = "Whadda ya want kid? Tell your friends about our fresh mangos!"
var Mechanic = "We fix cars here, no generators... But I do have an extra oxygen tank you can have."
var Barber = "I am very busy right now. Why don't you take a seat and read a magazine for now?"
var Farmer = "This here windmill doesn't generate nearly enough electricity!"
var Glider = "Damn it! I'm not sure I have the confidence to fly this bad boy."
var Diver = "Hi"
var Oscar = "Hi"

func _ready():
	pass

func _on_player_interact_talk(NPC_name):
	# open or close dialog box
	if self.get_offset() == Vector2(0, 100):
		self.set_offset(Vector2(0, 0))
	else:
		self.set_offset(Vector2(0, 100))
	
	# set the text
	if NPC_name == BORIS:
		textbox.text = Boris
	elif NPC_name == VENDOR:
		textbox.text = Vendor
	elif NPC_name == MECHANIC:
		textbox.text = Mechanic
	elif NPC_name == BARBER:
		textbox.text = Barber
	elif NPC_name == FARMER:
		textbox.text = Farmer
	elif NPC_name == DIVER:
		textbox.text = Diver
	elif NPC_name == GLIDER:
		textbox.text = Glider
	elif NPC_name == OSCAR:
		textbox.text = Oscar

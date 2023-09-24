extends CanvasLayer

@onready var background = $Background
@onready var textbox = $Text

enum {NONE, BORIS, VENDOR, MECHANIC, BARBER, FARMER} # NPC enum

var Boris = "We need to fix the generator to provide power. Igor, fetch me parts to fix it!"
var Vendor = "Whadda ya want kid? Tell your friends about our fresh mangos!"
var Mechanic = "We fix cars here, no generators... But I do have an extra oxygen tank you can have."
var Barber = "I am very busy right now...Why don't you take a seat and read a magazine while you wait?"
var Farmer = "Hi"


func _ready():
	# hide on startup!
	self.visible = false

func _on_player_interact_talk(NPC_name):
	# open or close dialog box
	if self.visible == false:
		self.visible = true
	else:
		self.visible = false
	
	# set the text
	if NPC_name == BORIS:
		textbox.text = Boris
	elif NPC_name == VENDOR:
		textbox.text = Vendor

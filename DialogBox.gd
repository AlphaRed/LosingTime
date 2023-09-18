extends CanvasLayer

@onready var background = $Background
@onready var textbox = $Text

enum {NONE, BORIS, VENDOR, MECHANIC} # NPC enum

var Boris = "We need to fix the generator to provide power. Igor, fetch me parts to fix it!"

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

extends CanvasLayer

@onready var background = $Background
@onready var textbox = $Text

enum {NONE, BORIS, VENDOR, MECHANIC, BARBER, FARMER, GLIDER, DIVER, OSCAR} # NPC enum
enum {NO_ITEM, O2TANK, SNORKEL, MAGAZINE, FAN, MATTRESS, BELLOWS} # Item enum

var Boris = "We need to fix the generator to provide power. Igor, fetch me parts to fix it!"
var Vendor = "Whadda ya want kid? Tell your friends about our fresh mangos!"
var Vendor_other = "Wow! Those monsters bought me out. Here's something for the help!"
var Mechanic = "We fix cars here, no generators... But I do have an extra oxygen tank you can have."
var Mechanic_other = "Get outta my sight! I already gave you that oxygen tank for free!"
var Barber = "I am very busy right now. Why don't you take a seat and read a magazine for now?"
var Farmer = "This here windmill doesn't generate nearly enough electricity!"
var Farmer_other = "That magazine has an article on geothermal energy! I won't need this."
var Glider = "Damn it! I'm not sure I have the confidence to fly this bad boy."
var Glider_other = "Whew! Thankfully this mattress softened my landing!"
var Diver = "I would like to go for a swim, but I haven't got an oxygen tank!"
var Diver_other = "Thanks for the oxygen tank! Here's a snorkel if you wanna join me!"
var Oscar = "Garbare Gar Gaerg!! Trash Yum Yum!!"
var Oscar_other = "MANGOS?! Garbare Gar! We shall purchase many! Tell this vendor to deliver!"

signal add_item(item)

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
		if Globals.mangos_delivered == true:
			textbox.text = Vendor_other
			add_item.emit(BELLOWS)
		else:
			textbox.text = Vendor
			if Globals.mangos == false:
				Globals.mangos = true
	elif NPC_name == MECHANIC:
		if Globals.inventory.count("O2Tank") > 0:
			textbox.text = Mechanic_other
		else:
			textbox.text = Mechanic
	elif NPC_name == BARBER:
		textbox.text = Barber
	elif NPC_name == FARMER:
		if Globals.inventory.count("Magazine") > 0:
			textbox.text = Farmer_other
			Globals.drop_fan_item = true
			print("should appear!")
		else:
			textbox.text = Farmer
	elif NPC_name == DIVER:
		if Globals.inventory.count("O2Tank") > 0:
			textbox.text = Diver_other
			add_item.emit(SNORKEL)
		else:
			textbox.text = Diver
	elif NPC_name == GLIDER:
		if Globals.glider_confidence == true:
			textbox.text = Glider_other
		else:
			textbox.text = Glider
		if Globals.glider_confidence == false:
			Globals.glider_confidence = true
	elif NPC_name == OSCAR:
		if Globals.mangos == true:
			textbox.text = Oscar_other
			Globals.mangos_delivered = true
			Globals.mangos = false
		else:
			textbox.text = Oscar

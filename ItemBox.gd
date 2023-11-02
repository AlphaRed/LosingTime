extends CanvasLayer

@onready var O2Tank = $O2Tank
@onready var Snorkel = $Snorkel
@onready var Magazine = $Magazine
@onready var Fan = $Fan
@onready var Mattress = $Mattress
@onready var Bellows = $Bellows

func _ready():
	check_inventory()

func _process(_delta):
	check_inventory()

func check_inventory():
	if Globals.inventory.count("O2Tank") > 0:
		O2Tank.set_visible(true)
	else:
		O2Tank.set_visible(false)
	
	if Globals.inventory.count("Snorkel") > 0:
		Snorkel.set_visible(true)
	else:
		Snorkel.set_visible(false)
	
	if Globals.inventory.count("Magazine") > 0:
		Magazine.set_visible(true)
	else:
		Magazine.set_visible(false)
	
	if Globals.inventory.count("Fan") > 0:
		Fan.set_visible(true)
	else:
		Fan.set_visible(false)
	
	if Globals.inventory.count("Mattress") > 0:
		Mattress.set_visible(true)
	else:
		Mattress.set_visible(false)
	
	if Globals.inventory.count("Bellows") > 0:
		Bellows.set_visible(true)
	else:
		Bellows.set_visible(false)

extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus() # to use the keyboard on menu

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")
	
func _on_quit_button_pressed():
	get_tree().quit()

func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://control_menu.tscn")

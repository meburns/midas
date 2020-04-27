extends Node2D

func _ready() -> void:
	_change_level()

func _change_level() -> void:
	# First play transition sound
	SFX.play("Transition")
	# Then Figure out level infos and what message to display
	var nextLevel := Globals.currentLevel + 1
	get_node("RichTextLabel").append_bbcode("[center]" + Globals.transitionText[Globals.currentLevel] + "[/center]")
	Globals.currentLevel = nextLevel
	# Finally wait for a few seconds and then load the next level
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://src/levels/Level" + str(nextLevel) + ".tscn")

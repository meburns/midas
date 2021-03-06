extends Node2D

func _ready() -> void:
	_change_level()

func _change_level() -> void:
	# First play transition sound
	SFX.play("Transition")
	# Disable touch buttons (if they are visible)
	TouchButtons.set_visible(false)
	# Then Figure out level infos and what message to display
	var currentLevel := Database.get_level()
	var nextLevel := currentLevel + 1
	if (nextLevel > Globals.transitionText.size()):
		Database.set_story_completed(true)
		Database.set_level(1)
		get_tree().change_scene("res://src/transitions/Credits.tscn")
	else:
		get_node("RichTextLabel").append_bbcode("[center]" + Globals.transitionText[currentLevel] + "[/center]")
		Database.set_level(nextLevel)
		# Finally wait for a few seconds and then load the next level
		yield(get_tree().create_timer(2), "timeout")
		TouchButtons.set_visible(true)
		get_tree().change_scene("res://src/levels/Level" + str(nextLevel) + ".tscn")

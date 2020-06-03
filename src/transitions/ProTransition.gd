extends Node2D

func _ready() -> void:
	_change_level()

func _change_level() -> void:
	# First play transition sound
	SFX.play("Transition")
	# Disable touch buttons (if they are visible)
	TouchButtons.set_visible(false)
	# Then Figure out level infos and what message to display
	var currentLevel := Database.get_pro_level()
	var nextLevel := currentLevel + 1
	if (nextLevel > Globals.proLevels.size()):
		Database.set_pro_completed(true)
		Database.set_pro_level(1)
		get_tree().change_scene("res://src/Menu.tscn")
	else:
		get_node("RichTextLabel").append_bbcode("[center]" + Globals.proLevels[currentLevel] + "[/center]")
		Database.set_pro_level(nextLevel)
		# Finally wait for a few seconds and then load the next level
		yield(get_tree().create_timer(2), "timeout")
		TouchButtons.set_visible(true)
		get_tree().change_scene("res://src/proLevels/ProLevel" + str(nextLevel) + ".tscn")

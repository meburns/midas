extends Node2D


func _ready() -> void:
	TouchButtons.set_visible(false)
	for button in get_tree().get_nodes_in_group("levelButtons"):
		print(button.name)
		button.connect("pressed", self, "_set_level", [button])

func _set_level(button):
	var level = button.name.replace("Button","").to_int()
	Database.set_level(level)
	start_level()

func start_level() -> void:
	MusicPlayer.play()
	TouchButtons.set_visible(true)
	get_tree().change_scene("res://src/transitions/Transition.tscn")

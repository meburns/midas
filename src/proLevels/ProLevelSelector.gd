extends Node2D

var levelButton = preload("res://src/buttons/LevelButton.tscn")

func _ready() -> void:
	TouchButtons.set_visible(false)
	_create_buttons()
	# Set the width of the auto scrollbar
	$ScrollContainer.get_v_scrollbar().set_custom_minimum_size(Vector2(100,720))

func _create_buttons() -> void:
	var levels = Globals.proLevels
	for i in range(levels.size()):
		var lvl = levels[i]
#		# Load LevelButton Instance
		var button = levelButton.instance()
		# Map button to up/down functions
		button.connect("button_down", self, "_button_down", [button])
		button.connect("button_up", self, "_set_level", [i])
		# Set button text
		button.get_node("Label").set_text(lvl)
		# Add button with label to scrollContainer
		$ScrollContainer/VBoxContainer.add_child(button)

func _button_down(button: TextureButton) -> void:
	button.get_node("AnimatedSprite").play("press")
	var pos = button.get_node("Label").get_position() 
	button.get_node("Label").set_position(Vector2(pos.x, pos.y + 5))

func _set_level(level):
	Database.set_level(level)
	start_level()

func start_level() -> void:
	TouchButtons.set_visible(true)
	get_tree().change_scene("res://src/transitions/Transition.tscn")

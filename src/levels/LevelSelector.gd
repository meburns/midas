extends Node2D

var buttonFont = preload("res://assets/fonts/Baloo_Bhaina_2/normal_font.tres")

func _ready() -> void:
	TouchButtons.set_visible(false)
	_create_buttons()
	# Set the width of the auto scrollbar
	$ScrollContainer.get_v_scrollbar().set_custom_minimum_size(Vector2(100,720))

func _create_buttons() -> void:
	var levels = Globals.transitionText
	for i in range(levels.size()):
		var lvl = levels[i]
		var button = Button.new()
		var label = Label.new()
		# Create label
		label.set_text(lvl)
		label.set_align(1)
		label.set_valign(1)
		label.add_font_override("font", buttonFont)
		label.get_font("font").set_size(40)
		label.set_custom_minimum_size(Vector2(1180, 100))
		# Create button
		button.add_child(label)
		button.connect("pressed", self, "_set_level", [i])
		button.set_custom_minimum_size(Vector2(0, 100))
		# Add button with label to scrollContainer
		$ScrollContainer/VBoxContainer.add_child(button)

func _set_level(level):
	Database.set_level(level)
	start_level()

func start_level() -> void:
	TouchButtons.set_visible(true)
	get_tree().change_scene("res://src/transitions/Transition.tscn")

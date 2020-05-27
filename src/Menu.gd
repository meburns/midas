extends Node2D


func _ready() -> void:
	Database.set_endless_level(0)
	TouchButtons.set_visible(false)
	Music.play("Menu")
	get_node("MainTitle").set_bbcode("[wave freq=3]M   I   D  A   S[/wave]")
	if Database.get_story_completed():
		$EndlessButton.visible = true
		$EndlessButton.disabled = false
		$MainTitle.add_color_override("font_color", Color( 229, 203, 33, 255 ))
		$TitleSparkle.set_emitting(true)
		$Blocks.play("marquee")
	else:
		$EndlessButton.visible = false


func _input(_ev):
	if Input.is_action_pressed("ui_accept"):
		start_game()

func start_game() -> void:
	Music.play("Main")
	TouchButtons.set_visible(true)
	if Database.get_level() > 0:
		Database.set_level(Database.get_level() - 1)
	if Database.get_story_completed():
		get_tree().change_scene("res://src/levels/LevelSelector.tscn")
	else:
		get_tree().change_scene("res://src/transitions/Transition.tscn")


func _on_StoryButton_button_down() -> void:
	$StoryButton/AnimatedSprite.play("press")
	var pos = $StoryButton/Label.get_position() 
	$StoryButton/Label.set_position(Vector2(pos.x, pos.y + 5))

func _on_StoryButton_button_up() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	start_game()

func _on_SettingsButton_button_down() -> void:
	$SettingsButton/AnimatedSprite.play("press")
	var pos = $SettingsButton/Label.get_position() 
	$SettingsButton/Label.set_position(Vector2(pos.x, pos.y + 5))

func _on_SettingsButton_button_up() -> void:
	get_tree().change_scene("res://src/Settings.tscn")


func _on_EndlessButton_button_down() -> void:
	$EndlessButton/AnimatedSprite.play("press")
	var pos = $EndlessButton/Label.get_position() 
	$EndlessButton/Label.set_position(Vector2(pos.x, pos.y + 5))

func _on_EndlessButton_button_up() -> void:
	Music.play("Main")
	get_tree().change_scene("res://src/levels/EndlessLevel.tscn")

extends Node2D


func _ready() -> void:
	Database.set_endless_level(0)
	TouchButtons.set_visible(false)
	Music.play("Menu")
	if Database.get_pro_completed():
		$TitleSparkle.set_emitting(true)
	if Database.get_story_completed():
		$ProButton.visible = true
		$ProButton.disabled = false
		$Title.play("play")
	else:
		$ProButton.visible = false


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


func _on_ProButton_button_down() -> void:
	$ProButton/AnimatedSprite.play("press")
	var pos = $ProButton/Label.get_position()
	$ProButton/Label.set_position(Vector2(pos.x, pos.y + 5))


func _on_ProButton_button_up() -> void:
	Music.play("Main")
	TouchButtons.set_visible(true)
	if Database.get_pro_level() > 0:
		Database.set_pro_level(Database.get_pro_level() - 1)
	if Database.get_pro_completed():
		get_tree().change_scene("res://src/proLevels/ProLevelSelector.tscn")
	else:
		get_tree().change_scene("res://src/transitions/ProTransition.tscn")

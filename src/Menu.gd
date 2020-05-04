extends Node2D

func _ready() -> void:
	TouchButtons.set_visible(false)
	MusicPlayer.stop()
	get_node("MenuMusic").play()
	get_node("RichTextLabel").set_bbcode("[wave freq=3]M I D A S[/wave]")
	if Database.get_story_completed():
		get_node("LevelSelect").visible = true
		get_node("LevelSelect").disabled = false

func _input(_ev):
	if Input.is_action_pressed("ui_accept"):
		start_game()

func _on_Button_pressed() -> void:
	start_game()

func start_game() -> void:
	MusicPlayer.play()
	TouchButtons.set_visible(true)
	if Database.get_level() > 0:
		Database.set_level(Database.get_level() - 1)
	get_tree().change_scene("res://src/transitions/Transition.tscn")


func _on_CreditButton_pressed() -> void:
	MusicPlayer.play()
	get_tree().change_scene("res://src/transitions/Credits.tscn")

extends Node2D

func _ready() -> void:
	TouchButtons.set_visible(false)
	MusicPlayer.stop()
	get_node("MenuMusic").play()
	get_node("RichTextLabel").set_bbcode("[wave freq=3]M I D A S[/wave]")

func _input(_ev):
	if Input.is_action_pressed("ui_accept"):
		start_game()

func _on_Button_pressed() -> void:
	start_game()

func start_game() -> void:
	MusicPlayer.play()
	TouchButtons.set_visible(true)
	get_tree().change_scene("res://src/levels/Level1.tscn")


func _on_CreditButton_pressed() -> void:
	MusicPlayer.play()
	get_tree().change_scene("res://src/transitions/Credits.tscn")

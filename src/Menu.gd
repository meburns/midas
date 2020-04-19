extends Node2D

func _ready() -> void:
	var player = get_tree().get_current_scene().get_node("AudioStreamPlayer")
	player.play()

func _input(ev):
	if Input.is_action_pressed("ui_accept"):
		start_game()

func _on_Button_pressed() -> void:
	start_game()

func start_game() -> void:
	get_tree().change_scene("res://src/levels/Level1.tscn")

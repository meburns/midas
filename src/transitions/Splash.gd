extends Node2D

func _ready() -> void:
	Music.play("Splash")
	yield(get_tree().create_timer(0.75), "timeout")
	get_tree().change_scene("res://src/Menu.tscn")

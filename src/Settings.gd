extends Node2D


func _ready() -> void:
	TouchButtons.set_visible(false)
	set_button()

func set_button() -> void:
	var mobile_size = Database.get_mobile_size()
	if mobile_size == 1:
		$mobileSize.pressed = true
	else:
		$mobileSize.pressed = false


func _on_CreditsButton_pressed() -> void:
	MusicPlayer.play()
	get_tree().change_scene("res://src/transitions/Credits.tscn")


func _on_BackButton_pressed() -> void:
	get_tree().change_scene("res://src/Menu.tscn")


func _on_mobileSize_pressed() -> void:
	var old_mobile_size = Database.get_mobile_size()
	Database.set_mobile_size(!old_mobile_size)
	set_button()

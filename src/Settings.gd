extends Node2D


func _ready() -> void:
	TouchButtons.set_visible(false)
	if Database.get_music_mute() == 0:
		$MusicToggle/AnimatedSprite.play("on")
	else:
		$MusicToggle/AnimatedSprite.play("off")


func _on_mobileSize_pressed() -> void:
	var old_mobile_size = Database.get_mobile_size()
	Database.set_mobile_size(!old_mobile_size)
#	set_button()


func _on_BackButton_button_down() -> void:
	$BackButton/AnimatedSprite.play("press")
	var pos = $BackButton/Label.get_position() 
	$BackButton/Label.set_position(Vector2(pos.x, pos.y + 5))

func _on_BackButton_button_up() -> void:
	get_tree().change_scene("res://src/Menu.tscn")


func _on_CreditsButton_button_down() -> void:
	$CreditsButton/AnimatedSprite.play("press")
	var pos = $CreditsButton/Label.get_position() 
	$CreditsButton/Label.set_position(Vector2(pos.x, pos.y + 5))


func _on_CreditsButton_button_up() -> void:
	MusicPlayer.play()
	get_tree().change_scene("res://src/transitions/Credits.tscn")


func _on_MusicToggle_pressed() -> void:
	if Database.get_music_mute() == 0:
		$MusicToggle/AnimatedSprite.play("off")
		Database.set_music_mute(1)
	else:
		$MusicToggle/AnimatedSprite.play("on")
		Database.set_music_mute(0)

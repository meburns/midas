extends Node2D

func _ready() -> void:
	if Database.get_quick_credits():
		$BackButton.show()

	if !Database.get_quick_credits():
		yield(get_tree().create_timer(0.5), "timeout")
	$Label1.show()

	if !Database.get_quick_credits():
		yield(get_tree().create_timer(2), "timeout")
	$Label2.show()

	if !Database.get_quick_credits():
		yield(get_tree().create_timer(2), "timeout")
	$Label3.show()

	if !Database.get_quick_credits():
		# After this is played once through, show it quicker next time
		Database.set_quick_credits(1)
		get_tree().change_scene("res://src/Menu.tscn")


func _on_BackButton_button_down() -> void:
	$BackButton/AnimatedSprite.play("press")
	var pos = $BackButton/Label.get_position() 
	$BackButton/Label.set_position(Vector2(pos.x, pos.y + 5))

func _on_BackButton_button_up() -> void:
	get_tree().change_scene("res://src/Menu.tscn")

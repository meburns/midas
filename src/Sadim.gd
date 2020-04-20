extends KinematicBody2D

var touched: = false

func _on_TouchDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas":
		# She is gold :(
		if body._get_water_touched() == false and touched == false:
			touched = true
			get_node("Sprite").region_rect = Rect2(80, 160, 80, 80)
			SFX.play("Gold")
		# She is okay!
		if body._get_water_touched() == true and touched == false:
			touched = true
			get_node("Sprite").region_rect = Rect2(80, 240, 80, 80)
			SFX.play("Save")
			body._set_frozen()
			_load_next_level()

func _load_next_level() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	if (get_tree().get_current_scene().get_name() == "Level1"):
		get_tree().change_scene("res://src/transitions/Transition1.tscn")
	if (get_tree().get_current_scene().get_name() == "Level2"):
		get_tree().change_scene("res://src/transitions/Transition2.tscn")
	if (get_tree().get_current_scene().get_name() == "Level3"):
		get_tree().change_scene("res://src/transitions/Transition3.tscn")
	if (get_tree().get_current_scene().get_name() == "Level4"):
		get_tree().change_scene("res://src/transitions/Transition4.tscn")
	if (get_tree().get_current_scene().get_name() == "Level5"):
		get_tree().change_scene("res://src/transitions/Transition5.tscn")
	if (get_tree().get_current_scene().get_name() == "Level6"):
		get_tree().change_scene("res://src/transitions/Transition6.tscn")
	if (get_tree().get_current_scene().get_name() == "Level7"):
		get_tree().change_scene("res://src/transitions/Transition7.tscn")
	if (get_tree().get_current_scene().get_name() == "Level8"):
		get_tree().change_scene("res://src/transitions/Transition8.tscn")

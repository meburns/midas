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
	get_tree().change_scene("res://src/transitions/Transition.tscn")

extends KinematicBody2D

var touched: = false

func _on_TouchDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas":
		# She is gold :(
		if body._get_water_touched() == false and touched == false:
			touched = true
			get_node("Sprite").region_rect = Rect2(80, 160, 80, 80)
		# She is okay!
		if body._get_water_touched() == true and touched == false:
			touched = true
			get_node("Sprite").region_rect = Rect2(80, 240, 80, 80)
			_load_next_level()

func _load_next_level() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	if (get_tree().get_current_scene().get_name() == "Level1"):
		get_tree().change_scene("res://src/levels/Level2.tscn")
	if (get_tree().get_current_scene().get_name() == "Level2"):
		get_tree().change_scene("res://src/levels/Level3.tscn")
	if (get_tree().get_current_scene().get_name() == "Level3"):
		get_tree().change_scene("res://src/levels/Level4.tscn")
	if (get_tree().get_current_scene().get_name() == "Level4"):
		get_tree().change_scene("res://src/levels/Level5.tscn")
	if (get_tree().get_current_scene().get_name() == "Level5"):
		get_tree().change_scene("res://src/levels/Level1.tscn")

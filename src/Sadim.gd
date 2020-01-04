extends KinematicBody2D

var touched: = false

func _on_TouchDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas":
		if body._get_water_touched() == false and touched == false:
			touched = true
			get_node("Sprite").region_rect = Rect2(80, 160, 80, 80)
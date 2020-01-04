extends StaticBody2D

var touched: = false


func _on_MidasDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas":
		body._set_water_touched()

extends StaticBody2D

var touched: = false


func _set_touched() -> void:
	touched = true


func _on_MidasDetector_body_entered(body: PhysicsBody2D) -> void:
	print(touched)
	if body.get_name() == "Midas" && touched == false:
		_set_touched()
		body._set_water_touched()
		var player: = get_node("Splash")
		player.play()

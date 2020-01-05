extends Area2D



func _on_Outside_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas":
		get_tree().reload_current_scene()

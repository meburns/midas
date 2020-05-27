extends Area2D



func _on_Outside_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas":
		SFX.play("Redo")
		get_tree().reload_current_scene()

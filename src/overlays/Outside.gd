extends Area2D



func _on_Outside_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas":
		SFX.play("Redo")
		if get_tree().get_root().find_node("EndlessLevel", true, false):
			get_tree().get_root().find_node("EndlessLevel", true, false).reload_level()
		else:
			get_tree().reload_current_scene()

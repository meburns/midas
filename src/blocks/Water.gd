extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP
var _velocity: = Vector2.ZERO
var gravity: = 300.0
var touched: = false


func _set_touched() -> void:
	touched = true


func _on_MidasDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas" && touched == false && body._get_water_touched() == false:
		_set_touched()
		body._set_water_touched()
		var player: = get_node("Splash")
		player.play()


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

extends KinematicBody2D

const waterEffect = preload("res://src/players/WaterEffect.tscn")
const FLOOR_NORMAL: = Vector2.UP
var _velocity: = Vector2.ZERO
var gravity: = 300.0
var touched: = false


func _set_touched() -> void:
	touched = true
	var wInstance = waterEffect.instance()
	wInstance.set_position(Vector2(0,-83))
	wInstance.set_z_index(-10)
	wInstance.set_emitting(true)
	self.add_child(wInstance)


func _on_MidasDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas" && touched == false && body._get_water_touched() == false:
		_set_touched()
		body._set_water_touched()


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

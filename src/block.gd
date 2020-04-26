extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

var _velocity: = Vector2.ZERO

var speed: = Vector2(300.0, 500.0)
var gravity: = 300.0

var touched: = false

func _ready() -> void:
	set_physics_process(false)


func _touch() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	touched = true


func _on_TouchDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name() == "Midas":
		if body._get_water_touched() == false and touched == false:
			set_physics_process(true)
			_touch()
			get_node("block-sprite").region_rect = Rect2(160, 0, 80, 80)


func _on_BlockDetector_area_entered(_area: Area2D) -> void:
	set_physics_process(false)


func _on_SmashDetector_body_entered(body: PhysicsBody2D) -> void:
	if body and body.get_name() == "Midas" and touched == true:
		body._set_smashable(true)


func _on_SmashDetector_body_exited(body: Node) -> void:
	if body and body.get_name() == "Midas" and touched == true:
		body._set_smashable(false)


func _physics_process(delta: float) -> void:
	if touched == true:
		_velocity.y += gravity * delta
		_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y



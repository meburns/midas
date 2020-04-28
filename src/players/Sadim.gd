extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP
var _velocity: = Vector2.ZERO
var gravity: = 300.0
var touched: = false

func _on_TouchDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_name().substr(0,5) == "Block":
		if body.touched == true:
			_squashify()
	if body.get_name() == "Midas":
		# She is gold :(
		if body._get_water_touched() == false and touched == false:
			_goldify()
		# She is okay!
		if body._get_water_touched() == true and touched == false:
			touched = true
			get_node("Sprite").region_rect = Rect2(80, 240, 80, 80)
			SFX.play("Save")
			body._set_frozen()
			_load_next_level()

func _squashify() -> void:
	get_node("CollisionShape2D").free()
	yield(get_tree().create_timer(0.65), "timeout")
	get_node("Sprite").free()

func _goldify() -> void:
	touched = true
	get_node("Sprite").region_rect = Rect2(80, 160, 80, 80)
	SFX.play("Gold")

func _load_next_level() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://src/transitions/Transition.tscn")


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
extends KinematicBody2D

class_name Midas

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
var _velocity: = Vector2.ZERO
export var stomp_impulse: = 1000.0
export var waterTouched: = false
export var smashed: = false
export var frozen: = false

func _on_BlockDetector_body_entered(body: PhysicsBody2D) -> void:
	pass # Replace with function body.

# User water touched status
func _get_water_touched() -> bool:
	return waterTouched

# If the user has touched the water block, they can't make blocks turn gold
func _set_water_touched() -> void:
	if waterTouched == false:
		waterTouched = true
		get_node("Sprite").region_rect = Rect2(0, 240, 80, 80) # change to water-1 sprite
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("Sprite").region_rect = Rect2(0, 320, 80, 80) # change to water-2 sprite
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("Sprite").region_rect = Rect2(0, 80, 80, 80) # change to normal sprite


func _get_frozen() -> bool:
	return frozen

func _set_frozen() -> void:
	frozen = true


# User's smashed status
func _get_smashed() -> bool:
	return smashed

# Only allow users to be smashed if they are on the ground and not yet smashed
func _set_smashed() -> void:
	if smashed == false and is_on_floor():
		smashed = true
		get_node("Sprite").region_rect = Rect2(0, 160, 80, 80) # change to squashed sprite
		get_node("CollisionBody").scale = Vector2(1, 0.4) # squash midas sprite


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	# reload the current level on "refresh" key pressed
	if Input.is_action_just_pressed("refresh"):
		get_tree().reload_current_scene()


func get_direction() -> Vector2:
	var x_val: = 0
	# If the user is smashed, they can't moved left or right but can still fall
	if !smashed && !frozen:
		x_val = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return Vector2(	
		x_val,
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() and !_get_smashed() else 1.0
	)
	if Input.is_action_just_pressed("jump") and is_on_floor() and !_get_smashed():
		get_node("jump").play("jump")


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func stop_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out







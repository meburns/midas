extends KinematicBody2D

class_name Midas

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
var _velocity: = Vector2.ZERO
export var stomp_impulse: = 1000.0
export var waterTouched: = false
var waterAnimate: = false
export var smashable: = false
export var smashed: = false
export var frozen: = false
var jump_buffer = 10
var is_jumping = false

func _on_BlockDetector_body_entered(_body: PhysicsBody2D) -> void:
	pass # Replace with function body.

# User water touched status
func _get_water_touched() -> bool:
	return waterTouched

# If the user has touched the water block, they can't make blocks turn gold
func _set_water_touched() -> void:
	if waterTouched == false:
		waterAnimate = true
		waterTouched = true
		get_node("Sprite").modulate = Color(0,0,255) # Set modulate color to blue overlay
		get_node("Sprite").region_rect = Rect2(0, 240, 80, 80) # change to water-1 sprite
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("Sprite").region_rect = Rect2(0, 320, 80, 80) # change to water-2 sprite
		yield(get_tree().create_timer(0.2), "timeout")
		get_node("Sprite").region_rect = Rect2(0, 80, 80, 80) # change to normal sprite
		waterAnimate = false


func _get_frozen() -> bool:
	return frozen

func _set_frozen() -> void:
	frozen = true


func _set_smashable(val: bool) -> void:
	smashable = val

# User's smashed status
func _get_smashed() -> bool:
	return smashed

# Only allow users to be smashed if they are on the ground and not yet smashed
func _check_smashed() -> void:
	if smashable == true and smashed == false and is_on_floor():
		SFX.play("Squash")
		smashed = true
		get_node("Sprite").region_rect = Rect2(0, 160, 80, 80) # change to squashed sprite
		get_node("CollisionBody").scale = Vector2(1, 0.4) # squash midas sprite


func _physics_process(_delta: float) -> void:
	if is_on_floor():
		jump_buffer = 10
		is_jumping = false
	jump_buffer -= 1

	if is_on_floor() and waterAnimate == false and smashed == false and frozen == false:
		get_node("Sprite").region_rect = Rect2(0, 80, 80, 80) # change to normal sprite
	_check_smashed() # Check if the user should be considered smashed
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	# reload the current level on "refresh" key pressed
	if Input.is_action_just_pressed("refresh"):
		SFX.play("Redo")
		get_tree().reload_current_scene()


func get_direction() -> Vector2:
	var x_val: = 0
	# If the user is smashed, they can't moved left or right but can still fall
	if !smashed && !frozen:
		x_val = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		if (x_val > 0 or x_val < 0) and is_on_floor() == true:
			get_node("Sprite").region_rect = Rect2(0, 480, 80, 80) # change to run sprite
			if x_val > 0:
				get_node("Sprite").set_flip_h(false)
			if x_val < 0:
				get_node("Sprite").set_flip_h(true)
	return Vector2(	
		x_val,
		-1.0 if Input.is_action_just_pressed("jump") and !is_jumping and jump_buffer > 0 and !_get_smashed() else 1.0
	)


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if !smashed && !frozen:
		if direction.y == -1.0:
			is_jumping = true
			SFX.play("Jump")
			get_node("Sprite").region_rect = Rect2(0, 400, 80, 80) # change to jump sprite
			out.y = speed.y * direction.y
		if is_jump_interrupted:
			out.y = 0.0
	return out

func stop_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out







extends Node2D

const block = preload("res://src/blocks/block.tscn")
const water = preload("res://src/blocks/Water.tscn")
const midas = preload("res://src/players/Midas.tscn")
const sadim = preload("res://src/players/Sadim.tscn")

var arr
var levelNode

var midas_x
var midas_y
var sadim_x
var sadim_y
var water_x
var water_y

func _ready() -> void:
	TouchButtons.set_visible(true)
	arr = _create_array()
	arr = _place_midas(arr)
	arr = _place_sadim(arr)
	arr = _place_water(arr)
	arr = _find_path(arr)
	arr = _clean_path(arr)
	#arr = _randomize_array(arr)
	_fill_array(arr)
	$Highscore.text = str(Database.get_endless_highscore())
	$CurrentLevel.text = str(Database.get_endless_level())


# Special endless level reload logic
func reload_level() -> void:
	for child in $level.get_children():
		child.queue_free()
	_fill_array(arr)

func skip_level() -> void:
	get_tree().reload_current_scene()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip"):
		skip_level()


func get_next_level() -> void:
	var current_level = Database.get_endless_level() + 1
	Database.set_endless_level(current_level)
	var current_highscore = Database.get_endless_highscore()
	if current_highscore < current_level:
		Database.set_endless_highscore(current_level)
	$Highscore.text = str(Database.get_endless_highscore())
	$CurrentLevel.text = str(Database.get_endless_level())
	get_tree().reload_current_scene()


func _create_array() -> Array:
	# 24x14 for 1080p screen size
	# 16x9 for 720p screen size
	var arr:= [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	]
	return arr


func _place_midas(arr: Array) -> Array:
	var y = floor(rand_range(3, 7))
	var x = floor(rand_range(2, 14))
	arr[y][x] = 2 #midas
	arr[y+1][x] = 1
	arr[y+2][x] = 1
	midas_x = x
	midas_y = y
	return arr

func _place_sadim(arr: Array) -> Array:
	var y = floor(rand_range(3, 7))
	var x = floor(rand_range(2, 14))
	if (arr[y][x] != 0 || arr[y+1][x] != 0 || arr[y+2][x] != 0):
		return _place_sadim(arr)
	else:
		arr[y][x] = 3 #sadim
		arr[y+1][x] = 1
		sadim_x = x
		sadim_y = y
		return arr

func _place_water(arr: Array) -> Array:
	var y = floor(rand_range(3, 7))
	var x = floor(rand_range(2, 14))
	if (arr[y][x] != 0 || arr[y+1][x] != 0 || arr[y+2][x] != 0):
		return _place_water(arr)
	else:
		arr[y][x] = 4 #water
		arr[y+1][x] = 1
		water_x = x
		water_y = y
		return arr


func _find_path(arr: Array) -> Array:
	var over = true
	for i in arr.size():
		# Set certain Y barriers for the blocks to stay inside
		if ((i > midas_y && i < sadim_y) || (i < midas_y && i > sadim_y) || (i == midas_y || i == sadim_y)):
			for j in arr[i].size():
				if ((j > midas_x && j < sadim_x) || (j < midas_x && j > sadim_x) || (j == midas_x || j == sadim_x)):
					if (arr[i][j] == 0):
						if over:
							arr[i][j] = 1
							over = false
						else:
							over = true
						
		if ((i > midas_y && i < water_y) || (i < midas_y && i > water_y) || (i == midas_y || i == water_y)):
			for j in arr[i].size():
				if ((j > midas_x && j < water_x) || (j < midas_x && j > water_x) || (j == midas_x || j == water_x)):
					if (arr[i][j] == 0):
						if over:
							arr[i][j] = 1
							over = false
						else:
							over = true
	return arr

func _clean_path(arr: Array) -> Array:
	for i in arr.size():
		if i < midas_y && arr[i][midas_x] == 1:
				arr[i][midas_x] = 0
	for i in arr.size():
		if i < sadim_y && arr[i][sadim_x] == 1:
				arr[i][sadim_x] = 0
	for i in arr.size():
		if i < water_y && arr[i][water_x] == 1:
				arr[i][water_x] = 0

	return arr

func _randomize_array(arr: Array) -> Array:
	var randomized_arr = arr
	for i in arr.size():
		# Set certain Y barriers for the blocks to stay inside
		if (i > 1 && i < arr.size()):
			for j in arr[i].size():
				# Set certain X barriers for the blocks to stay inside
				if (j > 2 && j < arr[i].size()):
					# Flip a coin
					if (floor(rand_range(0, 2)) == 1):
						arr[i][j] = 1
	return randomized_arr


func _fill_array(arr: Array) -> void:
	var level = Node2D.new()
	for i in arr.size():
		var x_val = (i * 80) + 1
		for j in arr[i].size():
			var y_val = (j * 80) + 1
			if (arr[i][j] == 1):
				var bInstance = block.instance()
				bInstance.set_position(Vector2(y_val, x_val))
				level.add_child(bInstance)
			if (arr[i][j] == 2):
				var mInstance = midas.instance()
				mInstance.set_position(Vector2(y_val, x_val))
				level.add_child(mInstance)
			if (arr[i][j] == 3):
				var sInstance = sadim.instance()
				sInstance.set_position(Vector2(y_val, x_val))
				level.add_child(sInstance)
			if (arr[i][j] == 4):
				var wInstance = water.instance()
				wInstance.set_position(Vector2(y_val, x_val))
				level.add_child(wInstance)
	$level.add_child(level)


func _on_SkipButton_button_down() -> void:
	$SkipButton/AnimatedSprite.play("press")
	var pos = $SkipButton/Label.get_position()
	$SkipButton/Label.set_position(Vector2(pos.x, pos.y + 5))
	yield(get_tree().create_timer(0.3), "timeout")
	skip_level()

func _on_SkipButton_button_up() -> void:
	$SkipButton/AnimatedSprite.play("idle")
	var pos = $SkipButton/Label.get_position()
	$SkipButton/Label.set_position(Vector2(pos.x, pos.y - 5))

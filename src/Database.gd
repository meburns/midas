extends Node

var db = "user://game.json"

func _ready() -> void:
	_initialize_if_not_exist()


func _initialize_if_not_exist() -> void:
	var file2Check = File.new()
	if !file2Check.file_exists(db):
		var f = File.new()
		var init_data = JSON.parse("""{
			"current_level": 0,
			"story_mode_completed": false,
			"endless_level": 0,
			"endless_highscore": 0,
			"mobile_size": 0
		}""").result
		f.open(db, File.WRITE)
		f.store_string(JSON.print(init_data, "  ", true))
		f.close()


func get_data() -> Array:
	var f = File.new()
	f.open(db, File.READ)
	var json = JSON.parse(f.get_as_text())
	f.close()
	return json.result


func set_data(key: String, value: int) -> void:
	var data = get_data()
	data[key] = value
	var f = File.new()
	f.open(db, File.WRITE)
	f.store_string(JSON.print(data, "  ", true))
	f.close()


func get_level() -> int:
	var data = get_data()
	return data["current_level"]

func set_level(new_level: int) -> void:
	set_data("current_level", new_level)


func get_story_completed() -> bool:
	var data = get_data()
	return data["story_mode_completed"]

func set_story_completed(completed: bool) -> void:
	set_data("story_mode_completed", completed)



func get_endless_level() -> int:
	var data = get_data()
	return data["endless_level"]

func set_endless_level(new_level: int) -> void:
	set_data("endless_level", new_level)

func get_endless_highscore() -> int:
	var data = get_data()
	return data["endless_highscore"]

func set_endless_highscore(new_score: int) -> void:
	set_data("endless_highscore", new_score)


func get_mobile_size() -> int:
	var data = get_data()
	return data["mobile_size"]

func set_mobile_size(new_size: int) -> void:
	set_data("mobile_size", new_size)

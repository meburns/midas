extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var player_table: = "player"

func _ready() -> void:
	db = SQLite.new()
	db.path = "res://data/game"
	db.open_db()

	_initialize_if_not_exist()
	if (_get_player().size() < 1):
		_create_player()


func _initialize_if_not_exist() -> void:
	var table_dict : Dictionary = Dictionary()
	table_dict["id"] = {"data_type":"int", "primary_key": true, "not_null": true, "default": 0}
	table_dict["current_level"] = {"data_type":"int", "not_null": true, "default": 0}
	table_dict["story_mode_completed"] = {"data_type":"boolean", "not_null": true, "default": false}
	db.create_table(player_table, table_dict)


func _create_player() -> Array:
	var new_player_dict : Dictionary = Dictionary()
	new_player_dict["id"] = 0
	new_player_dict["current_level"] = 0
	new_player_dict["story_mode_completed"] = false
	db.insert_row(player_table, new_player_dict)
	return _get_player()


func _get_player() -> Array:
	var player = db.select_rows(player_table, "", ["id", "current_level", "story_mode_completed"])
	return player


func get_level() -> int:
	return _get_player()[0]["current_level"]

func set_level(new_level: int) -> void:
	db.update_rows(player_table, "id = 0", {"current_level": new_level})

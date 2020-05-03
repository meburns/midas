extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db

func _ready() -> void:
	db = SQLite.new()
	db.path = "res://data/db"
	db.verbose_mode = true
	db.open_db()
	
	var table_dict : Dictionary = Dictionary()
	table_dict["current_level"] = {"data_type":"int", "primary_key": true, "not_null": true, "default": 0}
	table_dict["story_mode_completed"] = {"data_type":"boolean", "not_null": true, "default": false}
	
	db.create_table("player", table_dict)
	var pap = db.select_rows("player", "", ["current_level", "story_mode_completed"])
	print(pap)

extends Node2D

func _ready() -> void:
	_add_text([
		"Created with love\n using Godot Engine",
		"Heavily Inspired by\n Wanderlands' Midas\n for Ludum Dare 22",
		"Midas\n by meburns",
	])

func _add_text(arr: Array) -> void:
	var i: = 0
	while (i < arr.size()):
		var text: = ""
		var j: = 0
		var tmod: = 0.0001
		while (j < arr[i].length()):
			text += arr[i][j]
			_set_text(text)
			yield(get_tree().create_timer(tmod), "timeout")
			j += 1
		if arr.size() - 1 == i:
			_set_text_with_wave(text)
		i += 1
		yield(get_tree().create_timer(2), "timeout")
	yield(get_tree().create_timer(5), "timeout")
	get_tree().change_scene("res://src/Menu.tscn")


func _set_text(val: String) -> void:
	get_node("RichTextLabel").set_bbcode("[center]" + val + "[/center]")

func _set_text_with_wave(val: String) -> void:
	get_node("RichTextLabel").set_bbcode("[center][wave freq=3]" + val + "[/wave][/center]")

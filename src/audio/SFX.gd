extends Node

func play(val: String) -> void:
	if Database.get_sfx_mute() == 0:
		get_node(val).play()

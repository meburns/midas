extends Node2D

func play(val: String) -> void:
	for node in self.get_children():
		node.stop()
	if Database.get_music_mute() == 0:
		get_node(val).play()

func stop(val: String) -> void:
	get_node(val).stop()

extends Node2D

func _ready() -> void:
	SFX.play("Transition")
	yield(get_tree().create_timer(2), "timeout")
	if (get_tree().get_current_scene().get_name() == "Transition1"):
		get_tree().change_scene("res://src/levels/Level2.tscn")
	if (get_tree().get_current_scene().get_name() == "Transition2"):
		get_tree().change_scene("res://src/levels/Level3.tscn")
	if (get_tree().get_current_scene().get_name() == "Transition3"):
		get_tree().change_scene("res://src/levels/Level4.tscn")
	if (get_tree().get_current_scene().get_name() == "Transition4"):
		get_tree().change_scene("res://src/levels/Level5.tscn")
	if (get_tree().get_current_scene().get_name() == "Transition5"):
		get_tree().change_scene("res://src/levels/Level6.tscn")
	if (get_tree().get_current_scene().get_name() == "Transition6"):
		get_tree().change_scene("res://src/levels/Level7.tscn")
	if (get_tree().get_current_scene().get_name() == "Transition7"):
		get_tree().change_scene("res://src/levels/Level8.tscn")
	if (get_tree().get_current_scene().get_name() == "Transition8"):
		get_tree().change_scene("res://src/levels/Level9.tscn")
	if (get_tree().get_current_scene().get_name() == "Transition9"):
		get_tree().change_scene("res://src/levels/Level1.tscn")

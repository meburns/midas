extends Node2D

var blink_rate = 100
var color

func _ready() -> void:
	color = $Sprite.modulate

func _process(delta: float) -> void:
	blink_rate -= 1
	if blink_rate < 0:
		color = color.inverted()
		$Sprite.set_modulate(color)
		blink_rate = 100

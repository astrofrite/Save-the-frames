extends Node2D

export var startposition : Vector2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.hide()
	var startposition = $Position2D.get_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_speedtest_gravtest():
	$Label.text = "prout"
	$Label.show()


func _on_speedtest2_gravtest():
	$Label.text = "prout"
	$Label.show()

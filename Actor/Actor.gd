extends KinematicBody2D
class_name Actor 

export var gravity: = 4000.0

export var speed: = Vector2(300.0, 1000.0)

var velocity: = Vector2.ZERO

func _physics_process(delta) -> void:
	velocity.y = gravity * delta
	 # a bouger dans les scripts des acteur
	
	

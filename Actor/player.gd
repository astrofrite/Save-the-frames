extends Actor

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 1.0
	)
	velocity = speed * direction
	velocity = move_and_slide(velocity)

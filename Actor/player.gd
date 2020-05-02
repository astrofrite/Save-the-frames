extends Actor

func _physics_process(delta):
	var is_jump_canceled = Input.is_action_just_released("ui_up")
	var direction = get_direction()
	velocity = calculate_move_velocity(velocity,direction,speed,is_jump_canceled)
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), -1.0 if can_jump() == true 
		 else 1.0
	)

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction : Vector2,
	speed: Vector2,
	jump_canceled: bool
	) -> Vector2:
		var new_velocity: = linear_velocity
		new_velocity.x = speed.x * direction.x
		new_velocity.y += gravity * get_physics_process_delta_time()
		if direction.y == -1.0 :
			new_velocity.y = speed.y * direction.y
			
		if jump_canceled ==true and new_velocity.y < 0.0:
			new_velocity.y = 0.0
		return new_velocity
		
		
		

func can_jump() -> bool:
	if Input.is_action_just_pressed("ui_up") and is_on_floor() :
		return true
	elif Input.is_action_just_pressed("ui_up") and is_on_wall() :
		return true
	else :
		return false

extends Actor

var gravstate = 2

func _ready():
	get_node("Camera2D/Label").hide()

func _physics_process(delta):
	var gravity_ = _grav(get_gravity_state())
	var is_jump_canceled = Input.is_action_just_released("ui_up")
	var direction = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, gravity_, is_jump_canceled)
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	if velocity.x != 0 :
		var sprite = $AnimatedSprite
		sprite.play()
		sprite.flip_v = false
		sprite.flip_h = velocity.x < 0
	else :
		$AnimatedSprite.stop()
		$AnimatedSprite.set_frame(0)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), -1.0 if can_jump() == true 
		 else 1.0
	)

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction : Vector2,
	speed: Vector2,
	_grav: float,
	jump_canceled: bool
	) -> Vector2:
		var new_velocity: = linear_velocity
		new_velocity.x = speed.x * direction.x
		new_velocity.y += _grav * get_physics_process_delta_time()
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

func get_gravity_state() -> int:
	if Input.is_action_pressed("gravity_1"):
		gravstate=1
	elif Input.is_action_pressed("gravity_2"):
		gravstate=2
	elif Input.is_action_pressed("gravity_3"):
		gravstate=3
	elif Input.is_action_pressed("gravity_4"):
		gravstate=4
	return gravstate
	

func _grav(gravity_state : int) -> float :
	var _grav
	if gravity_state == 1 :
		_grav = 200
	if gravity_state == 2:
		_grav = 400
	if gravity_state == 3 :
		_grav = 800
	if gravity_state == 4 :
		_grav = 1200
	return _grav


func _on_speedtest_test():
	if gravstate == 1:
		pass
	else :
		kill("gravity")
		pass
	
	

func kill(reas :String):
	get_node("AnimatedSprite").hide()
	var messagelabel = get_node("Camera2D/Label")
	if reas == "gravity" :
		messagelabel.text = "Killed by gravity"
		messagelabel.show()
	else :
		messagelabel.text = "Killed by ??"
		messagelabel.show()
	
	set_physics_process(false)
	

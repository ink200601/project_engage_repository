extends CharacterBody3D

var full_jump = 52.5 * 3 #Full jump height
var init_jump = full_jump * 0.55 #Height the player will reach in 4 frames
var gravity = -5 #The rate of acceleration when falling
var terminal_vel = 90 #Maximum speed the player can fall at

func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		_jump(delta)
	
	velocity.y += gravity
	
	
	if velocity.y < 0:
		velocity.y = clamp(velocity.y, -terminal_vel, terminal_vel)
	
	move_and_slide()
	
func _jump(delta):
	velocity = velocity.lerp(Vector3(0, init_jump, 0), full_jump * delta)
	print("jumped")

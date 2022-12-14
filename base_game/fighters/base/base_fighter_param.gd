extends CharacterBody3D
class_name Fighter

@export var weight : float
@export var gravity : float
@export var walk_speed : float
@export var run_speed : float
@export var initial_dash : float
@export var air_speed : float
@export var air_acceleration : float
@export var fall_speed : float
@export var fast_fall_speed : float

@export var full_hop : float
@export var short_hop : float
@onready var jump_height = full_hop
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var initial_jump = full_hop * 0.55
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak)
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak))
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))


@onready var speed = walk_speed
@onready var acceleration = 1000

@onready var director = $Director


func _physics_process(delta) -> void:
	
	
	velocity.y -= gravity
	
	
	if director.jump == true and is_on_floor():
		#$AnimationPlayer.play("jump squat")
		velocity = velocity.lerp(Vector3(0, initial_jump, 0), full_hop * delta)
	
	if director.direction.x != 0:
		velocity.x = move_toward(velocity.x,speed * director.direction.x, acceleration)
	
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	
	
	if velocity.y < 0:
		velocity.y = clamp(velocity.y, -fall_speed, fall_speed)
	
	
	move_and_slide()
	
	print(jump_height)
	
	for r in $PlatformDetection.get_children():
		if r.is_colliding():
			set_collision_mask_value(2, true)
		else:
			set_collision_mask_value(2, false)
	
	
	print(director.jump)
	
	
	if Input.is_action_pressed("down"):
		fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * 2

func get_gravity() -> float:
	return fall_gravity if velocity.y < 0.0 else jump_gravity


func hop(delta) -> void:
	#velocity = velocity.lerp(Vector3(0, initial_jump, 0), full_hop * delta)
	pass

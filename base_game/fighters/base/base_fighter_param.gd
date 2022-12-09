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

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak)
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak))
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))


@onready var speed = walk_speed
@onready var acceleration = 100

@onready var director = $Director

func _physics_process(delta) -> void:
	
	if not is_on_floor():
		velocity.y += get_gravity() * delta
	
	
	
	if director.jump == true:
		velocity.y = jump_velocity
	
	if director.direction.x != 0:
		velocity.x = move_toward(velocity.x,speed * director.direction.x, acceleration)
	
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	
	move_and_slide()
	
	print(velocity)


func get_gravity() -> float:
	return fall_gravity if velocity.y < 0.0 else jump_gravity

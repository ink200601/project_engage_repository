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

@onready var speed = walk_speed
@onready var acceleration = 100

@onready var director = $Director

func _physics_process(delta) -> void:
	
	velocity.y -= fall_speed * delta
	
	if director.jump == true:
		velocity.y += 100
	
	velocity.x = move_toward(velocity.x,speed * director.direction.x, acceleration)
	
	move_and_slide()
	
	print(velocity.x)

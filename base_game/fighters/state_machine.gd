extends Node

@onready var fighter = get_parent()
@onready var director = $"../Director"

@onready var weight = fighter.weight
@onready var fall_gravity = fighter.gravity
@onready var walk_speed = fighter.walk_speed
@onready var run_speed = fighter.run_speed
@onready var initial_dash = fighter.initial_dash
@onready var air_speed = fighter.air_speed
@onready var air_acceleration = fighter.air_acceleration
@onready var fall = fighter.fall_speed
@onready var fast_fall= fighter.fast_fall_speed

@onready var full_hop = fighter.full_hop
@onready var short_hop = fighter.short_hop

@onready var initial_jump = full_hop * 0.55

@onready var speed = walk_speed
@onready var acceleration = 1000
@onready var fall_speed = fall
@onready var gravity = fall_gravity

@onready var velocity = fighter.velocity

enum {
	GROUND,
	GROUNDATTACK,
	AIR,
	AIRATTACK,
	LAUNCHED
}

var state = GROUND

func _physics_process(delta) -> void:
	
	var velocity = fighter.velocity
	
	if fighter.is_on_floor():
		state = GROUND
	
	else:
		state = AIR
	
	match state:
		GROUND:
			
			reset_fall()
			
			if director.direction.x != 0:
				fighter.velocity.x = move_toward(fighter.velocity.x, speed * director.direction.x, acceleration)
			
			else:
				fighter.velocity.x = move_toward(fighter.velocity.x, 0, acceleration)
			
			if director.jump_input == true:
				fighter.velocity = fighter.velocity.lerp(Vector3(0, initial_jump, 0), full_hop * delta)
			
			fighter.move_and_slide()
		GROUNDATTACK:
			pass
		AIR:
			fighter.velocity.y -= gravity
			
			if director.direction.x != 0:
				fighter.velocity.x = move_toward(fighter.velocity.x, speed * director.direction.x, acceleration)
			else:
				fighter.velocity.x = move_toward(fighter.velocity.x, 0, acceleration)
			
			
			if velocity.y < 0:
				if director.down_input == true:
					fall_speed = fast_fall
				fighter.velocity.y = clamp(fighter.velocity.y, -fall_speed, fall_speed)
			
			fighter.move_and_slide()
		AIRATTACK:
			pass
		LAUNCHED:
			fighter.velocity.y -= gravity
			fighter.velocity.y = clamp(fighter.velocity.y, -fall_speed, fall_speed)
			fighter.move_and_slide()
	
#	print(fighter.velocity.y)

func reset_fall():
	fall_speed = fall
	

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
@onready var midair_hop = fighter.midair_hop
@onready var midair_jumps = fighter.midair_jumps

@onready var initial_jump = full_hop * 0.55

@onready var speed = walk_speed
@onready var acceleration = 1000
@onready var fall_speed = fall
@onready var gravity = fall_gravity


enum {
	STANDING,
	WALKING,
	INITIALDASH,
	DASHING,
	GROUNDATTACK,
	AIR,
	JUMP,
	HELPLESS
}

var previous_state

var state = STANDING
func _physics_process(delta) -> void:
	
	var current_state = state
	
	match state:
		STANDING:
			
			if director.direction.x != 0:
				fighter.velocity.x = move_toward(fighter.velocity.x, speed * director.direction.x, acceleration)
			else:
				fighter.velocity.x = move_toward(fighter.velocity.x, 0, 1)
			
			if director.jump_input == true:
				previous_state = state
				state = JUMP
			if !fighter.is_on_floor():
				director.air_jump_input = false
				state = AIR
			
		WALKING:
			pass
		AIR:
			director.air_jump_input = false
			fighter.velocity.y -= gravity
			
			if director.direction.x != 0:
				fighter.velocity.x = move_toward(fighter.velocity.x, speed * director.direction.x, acceleration)
			else:
				fighter.velocity.x = move_toward(fighter.velocity.x, 0, acceleration)
			
			if director.air_jump_input == true:
				fighter.velocity = fighter.velocity.lerp(Vector3(0, initial_jump, 0), midair_hop * delta)
			
			if fighter.velocity.y < 0:
				if director.down_input == true:
					fall_speed = fast_fall
				fighter.velocity.y = clamp(fighter.velocity.y, -fall_speed, fall_speed)
			
			if fighter.is_on_floor():
				previous_state = state
				state = STANDING

		JUMP:
			previous_state = state
			fighter.velocity = fighter.velocity.lerp(Vector3(0, initial_jump, 0), full_hop * delta)
			state = AIR
		HELPLESS:
			fighter.velocity.y -= gravity
			fighter.velocity.y = clamp(fighter.velocity.y, -fall_speed, fall_speed)
			fighter.move_and_slide()
	
	fighter.move_and_slide()
	print(previous_state)

func reset_fall():
	fall_speed = fall
	

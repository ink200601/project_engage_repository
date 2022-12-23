extends Node

@onready var fighter = get_parent()
@onready var director = $"../Director"
@onready var anim = $"../Mesh/AnimationPlayer"
@onready var mesh = $"../Mesh"

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
	CROUCHING,
	DOWNTILT,
	WALKING,
	INITIALDASH,
	DASHING,
	GROUNDATTACK,
	AIR,
	DAIR,
	JUMPSQUAT,
	JUMP,
	SHORTHOP,
	HELPLESS
}
var can_jump
var previous_state
var prev_frame_input_str = 0

var state = STANDING
func _physics_process(delta) -> void:
	
	var current_state = state
	match state:
		STANDING: 
			can_jump = true
			anim.play("Idle")
			midair_jumps = fighter.midair_jumps
			if director.direction.x != 0:
				state = WALKING
			else:
				fighter.velocity.x = move_toward(fighter.velocity.x, 0, 1)
			
			if director.down_input == true:
				state = CROUCHING
			
			if director.direction.x > 0:
				mesh.rotation.y = deg_to_rad(0)
			if director.direction.x < 0:
				mesh.rotation.y = deg_to_rad(180)
			
			if director.jump_input == true:
				state = JUMPSQUAT
			
			if !fighter.is_on_floor():
				state = AIR
		CROUCHING:
			fighter.velocity = Vector3.ZERO
			anim.play("Crouch")
			if director.down_input == false:
				state = STANDING
			if Input.is_action_just_pressed("attack"):
				state = DOWNTILT
			
			if director.jump_input == true:
				state = JUMPSQUAT
			
		DOWNTILT:
			anim.play("CrouchKick")
		WALKING:
			fighter.velocity.x = move_toward(fighter.velocity.x, speed * director.direction.x, acceleration)
			
			if director.direction.x == 0:
				state = STANDING
			
			if !fighter.is_on_floor():
				state = AIR
			
			if director.jump_input == true:
				state = JUMPSQUAT
			
			if director.direction.x > 0:
				mesh.rotation.y = deg_to_rad(0)
			if director.direction.x < 0:
				mesh.rotation.y = deg_to_rad(180)
			
		DASHING:
			if director.direction.x > 0:
				fighter.velocity.x = run_speed
			elif director.direction.x < 0:
				fighter.velocity.x = -run_speed
			
			if director.direction.x == 0:
				state = STANDING
			
			if !fighter.is_on_floor():
				state = AIR
		AIR:
			anim.play("Jump_FighterRig")
			if director.jump_input == false:
				can_jump = true
			
			fighter.velocity.y -= gravity
			
			if director.direction.x != 0:
				fighter.velocity.x = move_toward(fighter.velocity.x, speed * director.direction.x, acceleration)
			else:
				fighter.velocity.x = move_toward(fighter.velocity.x, 0, acceleration)
			
			if can_jump == true:
				if director.jump_input == true and midair_jumps > 0:
					midair_jumps -= 1
					state = JUMPSQUAT
			
			if fighter.velocity.y < 0:
				if director.down_input == true:
					fall_speed = fast_fall
				fighter.velocity.y = clamp(fighter.velocity.y, -fall_speed, fall_speed)
			
			
			if fighter.is_on_floor():
				previous_state = state
				state = STANDING
			
			if director.down_input == true:
				if Input.is_action_just_pressed("attack"):
					state = DAIR
				
			
			
		DAIR:
			anim.play("Stomp")
			fighter.velocity.y -= gravity
			if fighter.is_on_floor():
				state = STANDING
		
		JUMPSQUAT:
			anim.play("JumpSquat")
		
		JUMP:
			previous_state = state
			fighter.velocity = fighter.velocity.lerp(Vector3(0, initial_jump, 0), full_hop * delta)
			state = AIR
			if director.jump_input == true:
				can_jump = false
			
			
		SHORTHOP:
			fighter.velocity = fighter.velocity.lerp(Vector3(0, initial_jump, 0), short_hop * delta)
			state = AIR
			if director.jump_input == true:
				can_jump = false
		HELPLESS:
			fighter.velocity.y -= gravity
			fighter.velocity.y = clamp(fighter.velocity.y, -fall_speed, fall_speed)
			fighter.move_and_slide()
	
	fighter.move_and_slide()
	print(director.direction)
	
	if $"../PlatformDetection/RayCast3D".is_colliding():
		fighter.set_collision_mask_value(2, true)
	else:
		fighter.set_collision_mask_value(2, false)
	

func jump():
	
	if director.jump_input == true:
		state = JUMP
	else:
		state = SHORTHOP

func down_tilt_fin():
	state = CROUCHING

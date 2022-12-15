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
@export var percent: float
@export var knockback_vector: Vector3

@export var full_hop : float
@export var short_hop : float
@onready var jump_height = full_hop

@onready var initial_jump = full_hop * 0.55

@onready var speed = walk_speed
@onready var acceleration = 1000

@onready var director = $Director


func _ready() -> void:
	knockback_vector.z = 0
	knockback_vector = knockback_vector.normalized()


func _physics_process(delta) -> void:
	
	for r in $PlatformDetection.get_children():
		if r.is_colliding():
			set_collision_mask_value(2, true)
		elif !r.is_colliding() and not is_on_floor():
			set_collision_mask_value(2, false)
		
		if Input.is_action_pressed("down") and r.is_colliding():
			r.set_collision_mask_value(2, false)
			set_collision_mask_value(2, false)
		else:
			r.set_collision_mask_value(2, true)



func hop(delta) -> void:
	velocity = velocity.lerp(Vector3(0, initial_jump, 0), full_hop * delta)
	pass


func _on_hitbox_launched(body: Node3D, damage := 0.1, knockback_growth := 0.1, base_knockback := 0.1) -> void:
	velocity = (((((body.percent / 10 + body.percent * damage / 20) * 200 / body.weight + 100 * 1.4) + 18) * knockback_growth) + base_knockback) * knockback_vector
	$StateMachine.state = 4


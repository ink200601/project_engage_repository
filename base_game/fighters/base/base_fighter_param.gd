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

@export var full_hop : float
@export var short_hop : float
@export var midair_hop : float
@export var midair_jumps : float
@onready var jump_height = full_hop

@onready var initial_jump = full_hop * 0.55

@onready var speed = walk_speed
@onready var acceleration = 1000

@onready var director = $Director
@onready var state_mach = $StateMachine


func _physics_process(delta) -> void:
	pass



extends Node

@onready var direction = Vector3()

var jump = false

func _physics_process(_delta) -> void:
	
	if Input.is_action_just_pressed("select"):
		get_tree().quit()
		
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	
	
	
	
	if Input.is_action_pressed("jump"):
		jump = true
	else:
		jump = false

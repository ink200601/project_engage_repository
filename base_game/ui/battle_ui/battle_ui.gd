extends Control

@onready var fps = $Label

func _physics_process(delta):
	
	fps.text = str(Engine.get_frames_per_second())

extends Control



func _physics_process(delta) -> void:
	
	if Input.is_action_just_pressed("attack"):
		_on_button_pressed()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://stages/base/test_arena.tscn")

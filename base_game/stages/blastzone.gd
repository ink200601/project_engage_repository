extends Area3D

@onready var spawn_point = $"../../SpawnPoint"

func _on_body_exited(body):
	body.position = spawn_point.position

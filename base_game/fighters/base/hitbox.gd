extends Area3D


signal launched(body: Node3D)


func _on_body_entered(body: Node3D) -> void:
	if body == get_parent():
		return
	emit_signal("launched", body)

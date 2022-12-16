extends Area3D

@export var damage : float
@export var base_knockback : int
@export var knockback_growth : int
@export var knockback_vector : Vector3




func _on_body_entered(body):
	body.state_mach.state = 4
	body.percent += damage
	body.velocity = ((((((body.percent / 10 + body.percent * damage / 20) * 200 / body.weight + 100 * 1.4) + 18) * knockback_growth) + base_knockback) * knockback_vector) * 0.001

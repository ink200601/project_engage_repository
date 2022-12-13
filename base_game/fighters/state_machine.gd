extends Node


enum {
	GROUND,
	GROUNDATTACK,
	AIR,
	AIRATTACK
}

var state = GROUND

func _physics_process(delta) -> void:
	
	match state:
		GROUND:
			pass
		GROUNDATTACK:
			pass
		AIR:
			pass
		AIRATTACK:
			pass

extends Camera3D


@export var MIN_X := -20
@export var MAX_X := 20
@export var MIN_Y := -15
@export var MAX_Y := 15
@export var MIN_Z := 20
@export var MAX_Z := 50
@export var Z_FACTOR := 3

var combatants: Array


func _ready() -> void:
	combatants = $"../Combatants".get_children()


func _physics_process(delta: float) -> void:
	if combatants.size() == 0:
		return
	var average := Vector2()
	for c in combatants:
		average += Vector2(c.position.x, c.position.y)
	average /= combatants.size()
	position.x = clamp(average.x, MIN_X, MAX_X)
	position.y = clamp(average.y, MIN_Y, MAX_Y)
	if combatants.size() < 2:
		return
	var longest: float = combatants[0].position.distance_squared_to(combatants[1].position)
	for i in combatants.size():
		for j in range(i, combatants.size()):
			var c: float = combatants[i].position.distance_squared_to(combatants[j].position)
			if c > longest:
				longest = c
	longest = sqrt(longest) * Z_FACTOR
	position.z = clamp(longest, MIN_Z, MAX_Z)

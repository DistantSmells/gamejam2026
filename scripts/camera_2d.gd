extends Camera2D

@export var speed: Vector2 = Vector2(8, 0)
var furthest_world_x: float

func _ready():
	furthest_world_x = global_position.x

func _process(delta):
	position += speed * delta
	if global_position.x > furthest_world_x:
		furthest_world_x = global_position.x
	elif global_position.x < furthest_world_x:
		position.x += furthest_world_x - global_position.x

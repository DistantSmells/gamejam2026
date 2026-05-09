extends Camera2D

@export var lerp_coefficient: float = 0.1
@export var target : Node2D = null
@export var current_boundary : Area2D = null
var furthest_world_x: float

func _ready():
	if !current_boundary:
		pass
	#furthest_world_x = global_position.x

#func _process(delta):
	#
	#position += speed * delta
	#if global_position.x > furthest_world_x:
		#furthest_world_x = global_position.x
	#elif global_position.x < furthest_world_x:
		#position.x += furthest_world_x - global_position.x

func _physics_process(delta: float) -> void:
	if target != null:
		self.global_position = lerp(self.global_position, target.global_position, 0.7)

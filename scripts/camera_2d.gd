extends Camera2D

#@export var lerp_coefficient: float = 0.6
@export var target : Node2D = null
@export var current_boundary : Area2D = null
@export var zoom_target : float = 1.0
var furthest_world_x: float

func _physics_process(delta: float) -> void:
	if target != null:
		self.global_position = target.global_position
	self.zoom = lerp(self.zoom, Vector2(zoom_target, zoom_target), 0.03)

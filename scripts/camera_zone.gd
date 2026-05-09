extends Area2D

signal camera_zone_entered
signal camera_zone_exited

#May need to change to filter based on groups
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		emit_signal("camera_zone_entered")
		set_camera_boundaries()
	
func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		emit_signal("camera_zone_exited")

func set_camera_boundaries() -> void:
	var children = get_parent().get_children()
	for child in children:
		if child is Camera2D:
			var size_x = $CollisionShape2D.shape.size.x / 2.0
			var size_y = $CollisionShape2D.shape.size.y / 2.0
			child.limit_left = $CollisionShape2D.global_position.x - size_x
			child.limit_right = $CollisionShape2D.global_position.x + size_x
			child.limit_top = $CollisionShape2D.global_position.y - size_y
			child.limit_bottom = $CollisionShape2D.global_position.y + size_y

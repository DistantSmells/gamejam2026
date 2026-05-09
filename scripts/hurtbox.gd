extends Area2D

signal hit

# Only filters for hitboxes...
func _on_area_entered(area: Area2D) -> void:
	emit_signal("hit")

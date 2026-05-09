extends Area2D

signal Triggered

func _on_body_entered(body: Node2D) -> void:
	emit_signal("Triggered")

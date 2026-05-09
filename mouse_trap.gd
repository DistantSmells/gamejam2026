extends AnimatedSprite2D

var triggered : bool = false

func _on_trigger_box_triggered() -> void:
	if triggered == false:
		self.play("Snap")
		triggered = true
		await get_tree().create_timer(0.1).timeout
		$Hitbox/CollisionShape2D.set("disabled", false)

func _on_physics_detection_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		if triggered == false:
			self.play("Snap")
			triggered = true

extends AnimatedSprite2D

var triggered : bool = false

func _ready():
	# Connect the signal to a function
	self.frame_changed.connect(_on_frame_changed)

func _on_frame_changed():
	# Check which animation and frame is active
	if frame == 1:
		AudioManager.play_sfx("res://assets/sounds/mouse_trap_short.wav", 0.0, 1.1)

func _on_trigger_box_triggered() -> void:
	if triggered == false:
		play_snap_effects()
		self.play("Snap")
		triggered = true
		await get_tree().create_timer(0.1).timeout
		$Hitbox/CollisionShape2D.set("disabled", false)

func _on_physics_detection_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		if triggered == false:
			play_snap_effects()
			self.play("Snap")
			triggered = true

# Created a helper function so you don't have to repeat the sound code twice
func play_snap_effects() -> void:
	self.play("Snap")
	triggered = true

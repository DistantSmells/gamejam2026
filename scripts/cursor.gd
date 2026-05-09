extends AnimatedSprite2D	

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position = get_global_mouse_position()
	if Input.is_action_pressed("LMB"):
		self.play("Closed")
	else:
		self.play("Open")

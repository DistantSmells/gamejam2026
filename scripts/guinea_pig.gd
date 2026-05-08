extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	# Optional: Set an initial limit if your level starts at X=0
	camera.limit_left = 0

func _physics_process(delta: float) -> void:
	# Add the gravity[cite: 7].
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump[cite: 7].
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get movement direction[cite: 9].
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# --- SIDE SCROLLER "NO BACK" LOGIC ---
	
	# 1. Calculate where the left edge of the screen is currently
	var viewport_width = get_viewport_rect().size.x / camera.zoom.x
	var current_left_edge = camera.get_screen_center_position().x - (viewport_width / 2)
	
	# 2. Update the camera's limit so it can never move further left than it has already traveled
	if current_left_edge > camera.limit_left:
		camera.limit_left = int(current_left_edge)
		
	# 3. Prevent the player from walking off the left side of the screen
	# We use a small margin (e.g., 60 pixels) based on the guinea pig's collision radius [cite: 2]
	var margin = 60.0 
	if global_position.x < camera.limit_left + margin:
		global_position.x = camera.limit_left + margin
		# Stop horizontal velocity if the player is pushing against the left "wall"
		if velocity.x < 0:
			velocity.x = 0

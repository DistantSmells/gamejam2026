extends RigidBody2D

# This creates a list in the Inspector where you can set the size to 3
@export var variations: Array[Texture2D] = []

@onready var sprite: Sprite2D = $Sprite2D

var has_clinked : bool = false

func _ready() -> void:
	if variations.size() > 0:
		# Picks a whole number between 0 and the size of your list
		var random_index = randi() % variations.size()
		# Assigns the chosen image to the Sprite2D's texture slot
		sprite.texture = variations[random_index]
	else:
		print("Warning: You forgot to drag your tack sprites into the array!")
		
	# 2. Setup Collision Sound
	# This connects the built-in 'body_entered' signal to our function below
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node) -> void:
	if not has_clinked:
		# Play the metal clink sound
		# We use a high pitch (1.4 - 1.8) because tacks are tiny and light
		var random_pitch = randf_range(1.4, 1.8)
		AudioManager.play_sfx("res://assets/sounds/metal_clink.wav", -8.0, random_pitch)
		
		# Mark as clinked so it doesn't noisily double-tap the floor
		has_clinked = true

extends RigidBody2D

# This creates a list in the Inspector where you can set the size to 3
@export var variations: Array[Texture2D] = []

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if variations.size() > 0:
		# Picks a whole number between 0 and the size of your list
		var random_index = randi() % variations.size()
		# Assigns the chosen image to the Sprite2D's texture slot
		sprite.texture = variations[random_index]
	else:
		print("Warning: You forgot to drag your tack sprites into the array!")

func _on_dropped():
	# Small delay to allow it to fall a bit, or check for collision
	await get_tree().create_timer(0.1).timeout
	
	# If it's touching the floor/wall, freeze it so it stays upright
	if get_contact_count() > 0:
		freeze = true

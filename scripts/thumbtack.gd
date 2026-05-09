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
		

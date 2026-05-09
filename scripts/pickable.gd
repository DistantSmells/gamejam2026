extends Area2D

@export_subgroup("Settings")
@export var parent : Node2D
## Changes if the parent position get's updated when pickable is moved.
#@export var grab_type: GrabType
#enum GrabType {UPDATE_PARENT_POSITION, NONE}

# Private variables
var hovered : bool = false
var one_shot : bool = false
#var is_held : bool = false
# Use callback from signals for information
signal grabbed
signal dropped

func _process(delta: float) -> void:
	# Determine if grabbed or dropped -> Sets whether held...
	# If mouse pressed while hovering "grab"
	if Input.is_action_just_pressed("LMB") and hovered == true:
		emit_signal("grabbed")
		print("Grabbed")
		one_shot = true
	# If mouse is released while hovering drop
	if Input.is_action_just_released("LMB") and one_shot:
		emit_signal("dropped")
		one_shot = false
		print("Dropped")
	
	## Actual processing parent stuff...
	#if is_held:
		#if grab_type == GrabType.UPDATE_PARENT_POSITION:
			#pass

func _ready() -> void:
	#If not parent is set, get parent
	if parent == null:
		parent = get_parent()

func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false

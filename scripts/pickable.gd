extends Area2D

@onready var parent : Node2D = get_parent()
@export_subgroup("Grab Type")
enum GrabType {UPDATE_PARENT_POSITION, NONE}
@export var grab_type: GrabType



func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	pass # Replace with function body.

extends CanvasLayer

func _on_start_button_pressed() -> void:
	# Replace with the actual path to your guinea_pig scene
	get_tree().change_scene_to_file("res://components/guinea_pig.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

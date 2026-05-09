extends CanvasLayer

func _ready() -> void:
	hide() # Is hidden at the start

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): # Usually the "Esc" key
		toggle_pause()

func toggle_pause() -> void:
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_resume_button_pressed() -> void:
	toggle_pause()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

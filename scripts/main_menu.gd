extends CanvasLayer

signal main_menu_freed

func _ready() -> void:
	get_tree().set("paused", true)

func _on_play_pressed() -> void:
	get_tree().set("paused", false)
	emit_signal("main_menu_freed")
	
	self.queue_free()


func _on_quit_pressed() -> void:
	get_tree().quit()

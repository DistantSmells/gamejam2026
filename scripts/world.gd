extends Node2D

var can_pause = false

func reload_level() -> void:
	pass


func _on_main_menu_main_menu_freed() -> void:
	can_pause = true

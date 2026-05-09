extends Node2D

var can_pause = false

func reload_level() -> void:
	pass


func _on_main_menu_main_menu_freed() -> void:
	can_pause = true


func _on_player_died() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	print("Player death...")

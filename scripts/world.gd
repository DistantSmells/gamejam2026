extends Node2D

var can_pause = false
var block_input : bool = false

func _ready():
	AudioManager.play_music("res://assets/sounds/bg_music_2.mp3")

func reload_level() -> void:
	pass


func _on_main_menu_main_menu_freed() -> void:
	can_pause = true


func _on_player_died() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().call_deferred("reload_current_scene")
	print("Player death...")

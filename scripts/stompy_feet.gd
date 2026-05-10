extends Node2D
# Animation

@export var frequency : float = 1.0


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "StompL":
		$AnimationPlayer.play("StompR")
	if anim_name == "StompR":
		$AnimationPlayer.play("StompL")

func play_stomp_sound() -> void:
	# Play stomp
	AudioManager.play_sfx("res://assets/sounds/stomp_cropped.wav")
	

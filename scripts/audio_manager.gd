extends Node

var music_player: AudioStreamPlayer
var background_chatter_player: AudioStreamPlayer
var sfx_bus = "SFX"
var music_bus = "Music"

func _ready():
	music_player = AudioStreamPlayer.new()
	background_chatter_player = AudioStreamPlayer.new()
	
	add_child(music_player)
	add_child(background_chatter_player)
	
	music_player.finished.connect(_on_music_finished)
	background_chatter_player.finished.connect(_on_background_chatter_finished)
	
	music_player.bus = music_bus
	background_chatter_player.bus = sfx_bus
	
	var stream = load("res://assets/sounds/freesound_community-kids-voices-with-natural-reverb-7094.mp3")
	background_chatter_player.stream = stream
	background_chatter_player.play()
	
	process_mode = Node.PROCESS_MODE_ALWAYS 

func play_music(music_path: String):
	var stream = load(music_path)
	if music_player.stream == stream:
		return
	music_player.stream = stream
	music_player.play()

func _on_background_chatter_finished(): #Play the bg chatter again when it finishes
	play_music("res://assets/sounds/freesound_community-kids-voices-with-natural-reverb-7094.mp3")
	
func _on_music_finished(): #Play the music again when it finishes
	play_music("res://assets/sounds/bg_music_2.mp3")

func play_sfx(sfx_path: String, volume_db: float = 0.0, pitch: float = 1.0):
	var stream = load(sfx_path)
	var sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	sfx_player.pitch_scale = randf_range(0.9, 1.1)
	sfx_player.stream = stream
	sfx_player.bus = sfx_bus
	sfx_player.volume_db = volume_db  # This controls the loudness
	sfx_player.pitch_scale = pitch
	sfx_player.play()
	sfx_player.finished.connect(sfx_player.queue_free)

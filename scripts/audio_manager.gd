extends Node

var music_player: AudioStreamPlayer
var sfx_bus = "SFX"
var music_bus = "Music"

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.bus = music_bus
	process_mode = Node.PROCESS_MODE_ALWAYS 

func play_music(music_path: String):
	var stream = load(music_path)
	if music_player.stream == stream:
		return
	music_player.stream = stream
	music_player.play()

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

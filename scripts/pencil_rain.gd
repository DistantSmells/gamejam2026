extends Node2D

@export var frequency : float = 1.0
@onready var pencil = preload("res://components/thumbtack.tscn")
@onready var collision: CollisionShape2D = $SpawnArea/CollisionShape2D
@onready var lower_x = global_position.x - (collision.shape.size.x / 2.0)
@onready var upper_x = global_position.x + (collision.shape.size.x / 2.0)
@onready var lower_y = global_position.y + (collision.shape.size.y / 2.0)
@onready var upper_y = global_position.y - (collision.shape.size.y / 2.0)


func _ready() -> void:
	randomize()
	$Timer.wait_time = 1.0 / frequency

func start() -> void:
	$Timer.start()

func stop() -> void:
	$Timer.stop()

func _on_timer_timeout() -> void:
	spawn_pencil()
	print("Timeout")

func spawn_pencil() -> void:
	var i_pencil = pencil.instantiate()
	get_parent().add_child(i_pencil)
	i_pencil.global_position.x = randf_range(lower_x, upper_x)
	i_pencil.global_position.y = randf_range(lower_y, upper_y)
	i_pencil.rotation_degrees = 180
	print("Spawned")

func _on_start_triggered() -> void:
	start()

func _on_stop_triggered() -> void:
	stop()

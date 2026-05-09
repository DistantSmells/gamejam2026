extends Node2D


var plane_accel = []
var plane_velocity = []

@export var plane_speed : float = 30.0
@export var plane_gravity : float = 0.2
@export var fan_stregth : float = 15.0
@onready var paper_plane = preload("res://components/paper_plane.tscn")

var planes = []

var can_free : bool = false

func _physics_process(delta: float) -> void:
	for i in planes.size():
		var plane = planes[i]
		var uplift : float = 0.0
		if plane.global_position.x > ($Fan.global_position.x - ($Fan/AOE/CollisionShape2D.shape.size.x / 2.0)):
			if plane.global_position.x < ($Fan.global_position.x + ($Fan/AOE/CollisionShape2D.shape.size.x / 2.0)):
				#uplift = (fan_stregth / plane.global_position.distance_to($Fan.global_position))
				pass
		#plane_accel[i].y -= uplift * delta
		#plane_accel[i].y += plane_gravity * delta
		#plane_velocity[i] += plane_accel[i] 
		plane_velocity[i].y -= uplift
		plane.move_and_collide(plane_velocity[i] * delta)


func _on_respawn_timer_timeout() -> void:
	var plane = paper_plane.instantiate()
	get_parent().add_child(plane)
	plane.global_position = $SpawnPoint.global_position
	planes.push_front(plane)
	plane_accel.push_front(Vector2(0.0, plane_gravity))
	plane_velocity.push_front(Vector2(plane_speed, 0.0))


func _on_deletion_timer_timeout() -> void:
	var deleted = planes.pop_back()
	deleted.queue_free()

extends Node2D

@onready var paper_plane_1: AnimatableBody2D = $PaperPlane
@onready var paper_plane_2: AnimatableBody2D = $PaperPlane2
@onready var paper_plane_3: AnimatableBody2D = $PaperPlane3

# All planes, path_data, and path_followers need to have the same number of elements.
@onready var planes = [paper_plane_1, paper_plane_2, paper_plane_3]
@onready var path_data = [$FlightPath/PathFollow2D/PathData, 
		$FlightPath/PathFollow2D2/PathData, $FlightPath/PathFollow2D3/PathData]
@onready var path_followers = [$FlightPath/PathFollow2D, $FlightPath/PathFollow2D2,
		$FlightPath/PathFollow2D3]

@export var time_to_traverse : float = 14.0

func _physics_process(delta: float) -> void:
	progress(delta)
	
func progress(delta: float) -> void:
	for path in path_followers:
		path.progress_ratio += (1 / time_to_traverse) * delta
	
	for i in planes.size():
		var plane = planes[i]
		var data = path_data[i]
		
		plane.global_position = data.global_position
		plane.global_rotation = lerp(plane.rotation, data.global_rotation, 0.1)

	
	#var target = $FlightPath/PathFollow2D/PathData.global_position
	#$PaperPlane.move_and_collide(target - $PaperPlane.global_position)
	#$PaperPlane.rotation = $FlightPath/PathFollow2D/PathData.rotation
#var plane_accel = []
#var plane_velocity = []
#
#@export var plane_speed : float = 30.0
#@export var plane_gravity : float = 0.2
#@export var fan_stregth : float = 15.0
#@onready var paper_plane = preload("res://components/paper_plane.tscn")
#
#var planes = []
#
#var can_free : bool = false
#
#func _ready() -> void:
	#pass
#
 
#func _physics_process(delta: float) -> void:
	#for i in planes.size():
		#var plane = planes[i]
		#var uplift : float = 0.0
		#if plane.global_position.x > ($Fan.global_position.x - ($Fan/AOE/CollisionShape2D.shape.size.x / 2.0)):
			#if plane.global_position.x < ($Fan.global_position.x + ($Fan/AOE/CollisionShape2D.shape.size.x / 2.0)):
				##uplift = (fan_stregth / plane.global_position.distance_to($Fan.global_position))
				#pass
		##plane_accel[i].y -= uplift * delta
		##plane_accel[i].y += plane_gravity * delta
		##plane_velocity[i] += plane_accel[i] 
		#plane_velocity[i].y -= uplift
		#plane.move_and_collide(plane_velocity[i] * delta)
#
#func spawn_plane() -> void:
	#var plane = paper_plane.instantiate()
	#get_parent().add_child(plane)
	#plane.global_position = $SpawnPoint.global_position
	#planes.push_front(plane)
	#plane_accel.push_front(Vector2(0.0, plane_gravity))
	#plane_velocity.push_front(Vector2(plane_speed, 0.0))
#
#func remove_plane() -> void:
	#var deleted = planes.pop_back()
	#deleted.queue_free()
#
#func _on_respawn_timer_timeout() -> void:
	#spawn_plane()
#
#func _on_deletion_timer_timeout() -> void:
	#remove_plane()

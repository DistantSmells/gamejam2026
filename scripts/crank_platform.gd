extends Node2D

#@export var time_to_traverse : float = 10.0
#@export var end_wait_time : float = 1.0
#@onready var speed : float = (1.0 / time_to_traverse)

@export var crank_ratio : float = 0.1
@export var decay_velocity : float = 20.0
@export var radius : float = 16.0
var is_held : bool = false
@onready var platform_path_follow = $platform_path/PathFollow2D
@onready var crank_path_follow = $crank_path/PathFollow2D
@onready var crank: Sprite2D = $Crank
@onready var crank_path: Path2D = $crank_path
@onready var line_2d: Line2D = $Crank/Line2D
@onready var platform_path: Path2D = $platform_path
@onready var crank_handle: Sprite2D = $crank_path/PathFollow2D/Pickable/Handle



var prev_mouse_pos : Vector2 = Vector2.ZERO

func _ready() -> void:
	var curve = Curve2D.new()
	var line = PackedVector2Array()
	
	var num_points = 20  # more = smoother

	for i in (num_points + 1):
		if (i > num_points):
			curve.add_point(curve.get_point_position(0))
			line.append(line[0])
			continue
		var angle = (float(i) / num_points) * TAU
		var point = Vector2(cos(angle), sin(angle)) * radius
		line.append(Vector2(cos(angle), sin(angle)) * radius)
		# The tangent controls the bezier handles - for a circle they're perpendicular
		var tangent = Vector2(-sin(angle), cos(angle)) * radius * (TAU / num_points) / 2.0
		curve.add_point(point, -tangent, tangent)
		crank_path.curve = curve
		line_2d.points = line

var sound_threshold : float = 0.0  # Tracks distance moved for sound triggers

func _process(delta: float) -> void:
	#CRANK PATH CODE...
	if is_held:
		#var offset = $Crank/Path2D.curve.get_closest_offset(get_global_mouse_position())
		#crank_path_follow.progress_ratio = offset / $Path2D.curve.get_baked_length()
		#var offset = crank_path_follow.progress_ratio * $Path2D.curve.get_baked_length()
		#var tangent = $Path2D.curve.sample_baked_with_rotation(offset).x
		#var mouse_delta = (get_global_mouse_position() - prev_mouse_pos)
		##var offset = crank_path_follow.progress_ratio * $Path2D.curve.get_baked_length()
		##var tangent = $Path2D.curve.sample_baked_with_rotation(offset).x
		#var length = $Path2D.curve.get_baked_length()
		#var offset = crank_path_follow.progress_ratio * length
		#var p1 = $Path2D.curve.sample_baked(offset)
		#var p2 = $Path2D.curve.sample_baked(offset + 10.0)
		#var tangent = (p2 - p1).normalized()
		##var tangent = crank_path_follow.transform.x  # unit vector tangent to path
		#var projected = mouse_delta.dot(tangent)
		#crank_path_follow.progress_ratio += projected / $Path2D.curve.get_baked_length()
		##crank_path_follow.progress_ratio += dot_prod * crank_ratio
		
		var center = crank.global_position
		var prev_angle = (prev_mouse_pos - center).angle()
		var curr_angle = (get_global_mouse_position() - center).angle()
		var angle_delta = angle_difference(prev_angle, curr_angle)
		#Quick fix for crank direction
		crank_path_follow.progress_ratio += angle_delta / TAU
		prev_mouse_pos = get_global_mouse_position()
		crank.rotation += angle_delta / (TAU / 6.28)
		
		# --- SOUND LOGIC START ---
		if abs(angle_delta) > 0.01: # Only play if the mouse actually moved
			sound_threshold += abs(angle_delta)
			
			# Play a sound every time the crank turns about 15 degrees (0.26 radians)
			if sound_threshold > 0.26:
				# Calculate pitch based on speed (angle_delta / delta)
				# This makes it sound "faster" when you spin faster!
				var speed = abs(angle_delta) / delta
				var pitch_val = clamp(1.0 + (speed * 0.05), 0.8, 2.5)
				
				AudioManager.play_sfx("res://assets/sounds/crank.wav", -10.0, pitch_val)
				sound_threshold = 0.0 # Reset threshold
		# --- SOUND LOGIC END ---
		
		
		#Update Linear Path
		platform_path_follow.progress_ratio += angle_delta / TAU * crank_ratio
	# Bound Linear Path
	if platform_path_follow.progress_ratio > 0.95:
		platform_path_follow.progress_ratio = 0.95
	if platform_path_follow.progress_ratio < 0.05:
		platform_path_follow.progress_ratio = 0.05
	
	# Regression When Not Cranking
	var regression_velocity = ( decay_velocity / platform_path.curve.get_baked_length() ) * delta
	platform_path_follow.progress_ratio -= regression_velocity
	
	


func _on_pickable_grabbed() -> void:
	prev_mouse_pos = get_global_mouse_position()
	is_held = true
	crank_handle.material.set_shader_parameter("width", 1.0)

func _on_pickable_dropped() -> void:
	is_held = false
	crank_handle.material.set_shader_parameter("width", 0.0)

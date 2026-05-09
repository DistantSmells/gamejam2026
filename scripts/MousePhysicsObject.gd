extends RigidBody2D

#var pin_joint: PinJoint2D
#var anchor: AnimatableBody2D

var is_held = false
var grab_offset := Vector2.ZERO
var prev_gloval_mouse_pos := Vector2.ZERO
enum ForceType {ALL, TORQUE}
@export var type : ForceType = ForceType.ALL

#const STIFFNESS := 600.0
#const DAMPING := 20.0
const SPEED = 30.0
const TORQUE_COEFFICIENT : float = 1.0
const MOUSE_COEFFICIENT : float = 1.4
const MOMENT_ARM_COEFFICIENT : float = 0.8
#const ANGULAR_DAMPING := 0.7

func _process(delta: float) -> void:
	if $Pickable.hovered and not self.is_held:
		$Sprite2D.material.set_shader_parameter("width", 1.0)
	else:
		$Sprite2D.material.set_shader_parameter("width", 0.0)

func _ready() -> void:
	self.can_sleep = false

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if !is_held:
		return
	##var grab_world_pos = global_transform * grab_offset
	var grab_world_pos = to_global(grab_offset)
	var global_mouse_pos = get_global_mouse_position()
	if type == ForceType.ALL:
		var displacement = global_mouse_pos - grab_world_pos
		state.linear_velocity = displacement * SPEED
	if type == ForceType.TORQUE:
		var displacement = global_mouse_pos - grab_world_pos
		state.linear_velocity = displacement * 0.2
	#state.angular_velocity *= (1.0 - ANGULAR_DAMPING * state.step)
	
	# Gravity torque around grab point
	var r = (global_position - grab_world_pos) * MOMENT_ARM_COEFFICIENT # COM relative to grab point
	var gravity_force = state.total_gravity * mass
	state.apply_torque(TORQUE_COEFFICIENT * r.cross(gravity_force))
	
	# Mouse swing torque
	var mouse_velocity = (global_mouse_pos - prev_gloval_mouse_pos) / state.step
	state.apply_torque(TORQUE_COEFFICIENT * MOUSE_COEFFICIENT * r.cross(-mouse_velocity * mass))
	
	prev_gloval_mouse_pos = global_mouse_pos
	
	#state.apply_force(displacement * STIFFNESS - state.linear_velocity * DAMPING, grab_offset)
	#state.apply_torque(-angular_velocity * ANGULAR_DAMPING)
	#state.angular_velocity = clamp(state.angular_velocity, -1.0, 1.0)
	#grab_offset = to_local(get_global_mouse_position())

#func _physics_process(delta: float) -> void:
	#if anchor:
		#anchor.global_position = anchor.global_position.lerp(
			#get_global_mouse_position(), 
			#delta * 30.0
		#)

func _on_pickable_grabbed() -> void:
	is_held = true
	#anchor = AnimatableBody2D.new()
	#anchor.sync_to_physics = true
	#get_parent().add_child(anchor)
	#anchor.global_position = get_global_mouse_position()
#
	#pin_joint = PinJoint2D.new()
	#pin_joint.global_position = get_global_mouse_position()
	#pin_joint.node_a = anchor.get_path()
	#pin_joint.node_b = self.get_path()
	#pin_joint.softness = 0.0   # lower = stiffer but more stable
	#pin_joint.bias = 0.1        # how aggressively it corrects positional error — lower = less spaz
	#get_parent().add_child(pin_joint)
	grab_offset = to_local(get_global_mouse_position())
	# Prevent frame spike due to garbage in uninitialized variable
	prev_gloval_mouse_pos = get_global_mouse_position() 

func _on_pickable_dropped() -> void:
	is_held = false
	#pin_joint.queue_free()
	#anchor.queue_free()
	#pin_joint = null
	#anchor = null

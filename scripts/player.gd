extends CharacterBody2D

signal died

const SPEED = 80.0
const JUMP_VELOCITY = 200.0

@export var push_force : float = 20.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_under: RayCast2D = $RayCastUnder

var left_limit := -INF

func _physics_process(delta: float) -> void:
	# Horizontal movement and animation
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("guinea walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("guinea idle")
		
	# Gravity
	if not is_on_floor():
		animated_sprite.play("guinea jump inair")
		velocity += get_gravity() * delta
		if ray_cast_under.is_colliding():
			animated_sprite.play("guinea jump land")

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_VELOCITY
		animated_sprite.play("guinea jump buildup")

	# Sprite flip
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	move_and_slide()
	
	# Iterate through all collisions that happened this frame
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Check if the object we hit is a RigidBody2D
		if collider is RigidBody2D:
			# Apply a force based on our velocity
			var force_direction = -collision.get_normal()
			collider.apply_impulse(force_direction * push_force)


func _on_hurtbox_hit() -> void:
	self.hide()
	var particles = CPUParticles2D.new()
	particles.one_shot = true
	particles.amount = 1000
	particles.lifetime = 0.5
	particles.explosiveness = 0.8
	particles.randomness = 0.2
	particles.lifetime = 0.4
	particles.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	particles.emission_sphere_radius = 1.0
	particles.direction = Vector2.ZERO
	particles.spread = 180.0
	particles.initial_velocity_min = 0.1
	particles.initial_velocity_max = 40.0
	particles.angle_max = 720.0
	particles.color.r = 1.0
	particles.color.g = 0.1
	particles.color.b = 0.1
	particles.color.a = 1.0
	get_parent().add_child(particles)
	particles.global_position = self.global_position
	emit_signal("died")
	set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)


func _on_cpu_particles_2d_finished() -> void:
	pass # Replace with function body.

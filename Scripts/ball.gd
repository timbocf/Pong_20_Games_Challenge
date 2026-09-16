extends CharacterBody2D

@export var initial_speed: float = 200.0
@export var speed_multiplier: float = 1.05
@export var max_speed: float = 1000.0
@export var max_bounce_angle: float = 60.0 # Max angle in degrees

@onready var hit_sound: AudioStreamPlayer2D = $HitSound

var current_speed: float

func _ready() -> void:
	current_speed = initial_speed
	# velocity = Vector2([-1, 1].pick_random(), randf_range(-0.5, 0.5)).normalized() * current_speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		
		if hit_sound:
			hit_sound.play()
		
		# Check if hitting the front/back face of a paddle
		if (collider.is_in_group("paddles") or collider is StaticBody2D) and abs(normal.x) > 0.5:
			# 1. Increase speed
			current_speed = min(current_speed * speed_multiplier, max_speed)
			
			# 2. Calculate vertical offset relative to paddle center (-1.0 to 1.0)
			var paddle_height: float = 100.0
			var y_diff = global_position.y - collider.global_position.y
			var relative_y: float = clamp(y_diff / (paddle_height / 2.0), -1.0, 1.0)
			
			# 3. Calculate bounce angle
			var bounce_angle: float = relative_y * deg_to_rad(max_bounce_angle)
			
			# 4. Use normal X direction to bounce away from paddle
			var x_dir: float = sign(normal.x)
			
			# 5. Set new directional velocity
			var new_dir = Vector2(x_dir * cos(bounce_angle), sin(bounce_angle))
			velocity = new_dir.normalized() * current_speed
			
			# 6. FIX: Use collision.get_depth() to push ball cleanly out of paddle
			global_position += normal * (collision.get_depth() + 2.0)
			
		else:
			# Standard bounce for top/bottom walls or paddle edges
			velocity = velocity.bounce(normal).normalized() * current_speed
			global_position += normal * (collision.get_depth() + 2.0)
		
func start_ball() -> void:
	# Pick a random starting direction 
	var random_angle = randf_range(-PI / 4, PI / 4)
	if randi() % 2 == 0:
		random_angle += PI
	velocity = Vector2(cos(random_angle), sin(random_angle)) * initial_speed

func reset_ball() -> void:
	current_speed = initial_speed
	global_position = get_viewport_rect().size / 2.0
	velocity = Vector2.ZERO
		

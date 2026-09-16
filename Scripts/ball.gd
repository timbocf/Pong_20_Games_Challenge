extends CharacterBody2D

@export var initial_speed: float = 200.0
@export var speed_multiplier: float = 1.05
@export var max_speed: float = 1000.0
@export var max_bounce_angle: float = 60.0 # Maximum bounce angle in degrees

@onready var hit_sound: AudioStreamPlayer2D = $HitSound

var current_speed: float

func _ready() -> void:
	current_speed = initial_speed
	# Random initial direction (left or right)
	velocity = Vector2([-1,1].pick_random(), randf_range(-0.5,0.5)).normalized() * current_speed
	# reset_ball()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		
		# Play the bounce sound on collision
		hit_sound.play()
		
		if collider.is_in_group("Paddles") or collider is StaticBody2D:
			# Increase speed
			current_speed = min(current_speed * speed_multiplier, max_speed)
			
			# Calculate vertical offset relative to paddle center (-1.0 to 1.0)
			var paddle_height: float = 80.0
			var relative_y: float = (global_position.y - collider.global_position.y) / (paddle_height / 2.0)
			relative_y = clamp(relative_y, -1.0, 1.0)
			
			# Calculate bounce angle in radians based on hit location
			var bounce_angle: float = relative_y * deg_to_rad(max_bounce_angle)
			
			# Determine horizontal bounce direction (left or right)
			var x_dir: float = 1.0 if velocity.x < 0 else -1.0
			
			# Construct new velocity vector from angle
			var new_dir = Vector2(x_dir * cos(bounce_angle), sin(bounce_angle))
			velocity = new_dir.normalized() * current_speed
			
			# Regular bounce for top/bottom walls
			velocity = velocity.bounce(collision.get_normal())
			# Maintain speed scalar after wall bounce
			velocity = velocity.normalized() * current_speed
		
func start_ball() -> void:
	# Pick a random starting direction 
	var random_angle = randf_range(-PI / 4, PI / 4)
	if randi() % 2 == 0:
		random_angle += PI
	velocity = Vector2(cos(random_angle), sin(random_angle)) * initial_speed

func reset_ball(serve_left: bool = true) -> void:
	global_position = get_viewport_rect().size / 2.0
	
	var x_dir = -1.0 if serve_left else 1.0
	var y_dir = randf_range(-0.5, 0.5)
	
	velocity = Vector2(x_dir, y_dir).normalized() * initial_speed
	
	# uncomment the next line if you want to have the player press spacebar after every point
	# velocity = Vector2.ZERO

extends CharacterBody2D

@export var initial_speed: float = 200.0
@export var speed_multiplier: float = 1.05
@export var max_speed: float = 1000.0

func _ready() -> void:
	reset_ball()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		var collider = collision.get_collider()
		if collider.is_in_group("Paddles"):
			var current_speed = velocity.length() * speed_multiplier
			current_speed = min(current_speed, max_speed)
			
			velocity = velocity.normalized() * current_speed	
			print(current_speed)
		
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

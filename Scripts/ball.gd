extends CharacterBody2D

var speed = 200

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var _collider = collision.get_collider()
		velocity = velocity.bounce(collision.get_normal())
		
func start_ball() -> void:
	# Pick a random starting direction 
	var random_angle = randf_range(-PI / 4, PI / 4)
	if randi() % 2 == 0:
		random_angle += PI
	velocity = Vector2(cos(random_angle), sin(random_angle)) * speed

func reset_ball() -> void:
	position = get_viewport_rect().size / 2
	# uncomment the next line if you want to have the player press spacebar after every point
	# velocity = Vector2.ZERO

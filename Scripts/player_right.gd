extends StaticBody2D

const SPEED = 400.0
@export var ball: Node2D
@export var margin: float = 10.0
@export var ai_speed: float = 150.0

func _physics_process(delta: float) -> void:
	var direction := 0.0
	var current_speed := SPEED
	
	if Globals.player_count == 2:
		# Player 2 Controls
		direction = Input.get_axis("move_up_right", "move_down_right")
		current_speed = SPEED
		
	else:
		# AI controls: Follow ball Y position
		current_speed = ai_speed
		if ball:
			var y_diff = ball.global_position.y - global_position.y
			if abs(y_diff) > margin:
				direction = sign(y_diff) # Returns 1.0 if ball is below, -1.0 if above
			
	# Apply movement
	position.y += direction * current_speed * delta
	
	# Keeps the paddle inside the window (adjust 50 and 430 to fit your screen height)
	position.y = clamp(position.y, 40, 440)

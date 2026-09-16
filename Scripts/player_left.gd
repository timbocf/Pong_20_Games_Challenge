extends StaticBody2D

const SPEED = 400.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_up_left", "move_down_left")
	position.y += direction * SPEED * delta
	
	# Keeps the paddle inside the window (adjust 50 and 590 to fit your screen height)
	position.y = clamp(position.y, 40, 440)

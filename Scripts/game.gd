extends Node2D

var left_player_score = 0
var right_player_score = 0
var game_started = false

@onready var ball = $Ball
@onready var left_score_label = $"Left Score Label"
@onready var right_score_label = $"Right Score Label"
@onready var start_label = $"Start Game Label"

func _ready() -> void:
	start_label.visible = true
	ball.velocity = Vector2.ZERO
	
func _unhandled_input(event: InputEvent) -> void:
	if not game_started and event.is_action_pressed("start_game"):
		game_started = true
		start_label.visible = false
		ball.start_ball()

func _on_left_boundary_body_entered(_body: Node2D) -> void:
	right_player_score += 1
	right_score_label.text = str(right_player_score)
	ball.reset_ball()
	game_started = false
	start_label.visible = true
	
func _on_right_boundary_body_entered(_body: Node2D) -> void:
	left_player_score += 1
	left_score_label.text = str(left_player_score)
	ball.reset_ball()
	game_started = false
	start_label.visible = true

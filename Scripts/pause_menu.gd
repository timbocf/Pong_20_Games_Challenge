extends CanvasLayer

@onready var menu_ui: Control = $MenuUI

func _ready() -> void:
	menu_ui.hide()
	
func _unhandled_input(event: InputEvent) -> void:
	# Toggle pause state on Escape or Start button press
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
		
func toggle_pause() -> void:
	var is_paused: bool = !get_tree().paused
	get_tree().paused = is_paused
	menu_ui.visible = is_paused
	
func _on_resume_button_pressed() -> void:
	toggle_pause()
	
func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

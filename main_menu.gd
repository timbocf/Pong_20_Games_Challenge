extends Control

func _on_one_player_button_pressed() -> void:
	Globals.player_count = 1
	get_tree().change_scene_to_file("res://game.tscn")
	
func _on_two_player_button_pressed() -> void:
	Globals.player_count = 2
	get_tree().change_scene_to_file("res://game.tscn")

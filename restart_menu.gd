extends Control

func _on_restart_button_button_down():
	get_tree().change_scene_to_file("res://battle_zone.tscn")

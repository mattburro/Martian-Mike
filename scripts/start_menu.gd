extends Control

func _ready():
	GameManager.time_elapsed = 0.0

func on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func on_leaderboard_button_pressed():
	get_tree().change_scene_to_file("res://scenes/leaderboard_menu.tscn")

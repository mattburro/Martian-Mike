extends Control

@onready var send_button = $SendButton
@onready var back_button = $BackButton
@onready var player_name_input = $PlayerNameInput

var sent = false

func _process(delta):
	if !sent:
		send_button.disabled = player_name_input.text.length() == 0

func on_send_button_pressed():
	sent = true
	send_button.disabled = true
	back_button.disabled = true
	
	var player_name = player_name_input.text.to_upper()
	var player_time = "%0.3f" % (GameManager.MAX_TIME - GameManager.time_elapsed)
	await SilentWolf.Scores.save_score(player_name, player_time).sw_save_score_complete
	
	back_button.disabled = false

func on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

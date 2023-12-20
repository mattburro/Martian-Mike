extends Control

func _ready():
	clear_scoreboard()
	
	var result: Dictionary = await SilentWolf.Scores.get_scores(5).sw_get_scores_complete
	
	var best_times = []
	for score in result.scores:
		var player_time = float("%0.3f" % (GameManager.MAX_TIME - score.score))
		best_times.append([score.player_name, player_time])
	
	for i in best_times.size():
		set_score(i + 1, best_times[i][0], best_times[i][1])

func set_score(index, name, time):
	var name_label = "%PlayerName" + str(index)
	get_node(name_label).text = name
	
	var time_label = "%PlayerTime" + str(index)
	var milliseconds = fmod(time, 1) * 1000
	var seconds = floor(time)
	get_node(time_label).text = "%0d:%3d" % [seconds, milliseconds]

func clear_scoreboard():
	%PlayerName1.text = ""
	%PlayerTime1.text = ""
	%PlayerName2.text = ""
	%PlayerTime2.text = ""
	%PlayerName3.text = ""
	%PlayerTime3.text = ""
	%PlayerName4.text = ""
	%PlayerTime4.text = ""
	%PlayerName5.text = ""
	%PlayerTime5.text = ""

func on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

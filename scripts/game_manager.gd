extends Node

const MAX_TIME = 1000000000.0

var time_elapsed = 0.0

func _ready():
	SilentWolf.configure({
		"api_key": "PFESz8WmU9mq4H3CNdcX9IKCmmapmRm7FQPfUfUh",
		"game_id": "MartianMike",
		"log_level": 1
	})

extends Node2D

@export var next_level: PackedScene = null

@onready var player = $Player
@onready var deathzone = $Deathzone
@onready var spawn_platform = $SpawnPlatform
@onready var exit_platform = $ExitPlatform
@onready var hud = $UI/HUD

var time_elapsed
var timer_active = false

func _ready():
	player.global_position = spawn_platform.get_spawn_position()
	
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touched_player.connect(on_trap_touched_player)
	
	deathzone.body_entered.connect(on_deathzone_body_entered)
	exit_platform.body_entered.connect(on_exit_platform_body_entered)
	
	time_elapsed = GameManager.time_elapsed
	timer_active = true

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	
	if timer_active:
		time_elapsed += delta
	
	var seconds = floor(time_elapsed)
	var milliseconds = fmod(time_elapsed, 1) * 1000
	hud.set_time_label("%0d:%3d" % [seconds, milliseconds])

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = spawn_platform.get_spawn_position()

func on_deathzone_body_entered(body):
	AudioPlayer.play_sound_effect("player_hurt")
	reset_player()

func on_trap_touched_player():
	AudioPlayer.play_sound_effect("player_hurt")
	reset_player()

func on_exit_platform_body_entered(body):
	exit_platform.animate()
	player.active = false
	timer_active = false
	GameManager.time_elapsed = time_elapsed
	
	if next_level:
		AudioPlayer.play_sound_effect("fanfare")
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_packed(next_level)
	else:
		AudioPlayer.play_sound_effect("cheer")
		$UI.show_win_screen(true)

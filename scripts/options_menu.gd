extends Control

@onready var music_slider = %MusicSlider
@onready var sfx_slider = %SfxSlider
@onready var back_button: Button = $%BackButton

func _ready():
	music_slider.value_changed.connect(on_audio_slider_changed.bind("music"))
	sfx_slider.value_changed.connect(on_audio_slider_changed.bind("sfx"))
	back_button.pressed.connect(on_back_button_pressed)
	update_display()

func update_display():
	sfx_slider.value = get_bus_volume_percent("sfx")
	music_slider.value = get_bus_volume_percent("music")

func get_bus_volume_percent(bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)

func set_bus_volume_percent(bus_name: String, percent: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volume_db = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index, volume_db)

func on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func on_audio_slider_changed(value: float, bus_name: String):
	set_bus_volume_percent(bus_name, value)

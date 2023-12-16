extends Node

var save_path = "user://led.save"

var levels = ["res://src/Levels/level_01.tscn",
				"res://src/Levels/level_02.tscn",
				"res://src/Levels/level_03.tscn",
				"res://src/Levels/level_04.tscn",
				"res://src/Levels/level_05.tscn",
				"res://src/Levels/level_06.tscn",
				"res://src/Levels/level_07.tscn",
				"res://src/Levels/level_08.tscn",
				"res://src/Levels/level_09.tscn",
				"res://src/Levels/level_10.tscn",
				]

var levels_time = [0.0, 0.0, 0.0, 0.0, 0.0,
					0.0, 0.0, 0.0, 0.0, 0.0]
var actual_level = 0

var volume = 0.3

func _ready():
	load_data()

func update_levels_time(id, value):
	levels_time[id] = value
	save_data()

func update_actual_level(value):
	actual_level = value
	save_data()

func update_volume(value):
	volume = value
	save_data()

func get_level_path(level):
	if level == len(levels):
		return "-1"
	return levels[level]

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	for i in len(levels_time):
		file.store_var(levels_time[i])
	file.store_var(actual_level)
	file.store_var(volume)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		for i in len(levels_time):
			levels_time[i] = file.get_var(i)
		actual_level = file.get_var(actual_level)
		volume = file.get_var(volume)

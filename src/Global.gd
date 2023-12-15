extends Node

var levels = ["res://src/Levels/level_01.tscn",
				"res://src/Levels/level_02.tscn",
				"res://src/Levels/level_03.tscn",
				"res://src/Levels/level_04.tscn",
				"res://src/Levels/level_05.tscn",
				"res://src/Levels/level_06.tscn",
				"res://src/Levels/level_07.tscn",
				"res://src/Levels/level_08.tscn",
				#"res://src/Levels/level_09.tscn",
				#"res://src/Levels/level_10.tscn",
				]

#var levels_time = [0.0, 0.0, 0.0, 0.0]
var actual_level = 0

func get_level_path(level):
	if level == len(levels):
		return "-1"
	return levels[level]

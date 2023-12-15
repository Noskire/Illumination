extends Control

func _ready():
	if Global.actual_level == 0:
		$VBox/Continue.disabled = true

func _on_new_button_up():
	Global.actual_level = 0
	var path = Global.get_level_path(Global.actual_level)
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

func _on_continue_button_up():
	var path = Global.get_level_path(Global.actual_level)
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

func _on_highscore_button_up():
	var path = "res://src/high_score.tscn"
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

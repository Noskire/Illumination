extends Control

func _ready():
	$VBox/New.grab_focus()
	if Global.actual_level == 0:
		$VBox/Continue.disabled = true
	$VBox/HBox/SoundSlider.value = Global.volume

func _on_new_button_up():
	Global.update_actual_level(0)
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

func _on_sound_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
	if not $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.play()
	Global.update_volume(value)

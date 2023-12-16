extends CanvasLayer

@onready var LabelTime = $Control/VBox/Time

var level_time = 0.0
var paused = false
var end_level = false

func _ready():
	if Global.get_level_path(Global.actual_level+1) == "-1":
		$Control/VBox/Next.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("pause") and not end_level:
		if paused:
			unpause()
		else:
			pause()

func pause():
	$Control/VBox/Title.visible = false
	$Control/VBox/Time.visible = false
	$Control/VBox/Next.visible = false
	$Control.visible = true
	get_tree().paused = true
	paused = true

func unpause():
	$Control/VBox/Title.visible = true
	$Control/VBox/Time.visible = true
	if Global.get_level_path(Global.actual_level+1) != "-1":
		$Control/VBox/Next.visible = true
	$Control.visible = false
	get_tree().paused = false
	paused = false

func open_menu(time):
	end_level = true
	$Control.visible = true
	var best_time = Global.levels_time[Global.actual_level]
	if time < best_time or best_time == 0.0:
		#Global.levels_time[Global.actual_level] = time
		Global.update_levels_time(Global.actual_level, time)
		var tmin = str(int(time / 60.0))
		var tseg = int(time) % 60
		if tseg < 10:
			tseg = "0" + str(tseg)
		else:
			tseg = str(tseg)
		$Control/VBox/Time.set_text("New Best Time: " + tmin + ":" + tseg)
	else:
		var tmin = str(int(best_time / 60.0))
		var tseg = int(best_time) % 60
		if tseg < 10:
			tseg = "0" + str(tseg)
		else:
			tseg = str(tseg)
		$Control/VBox/Time.set_text("Best Time: " + tmin + ":" + tseg)

func _on_next_button_up():
	var path = Global.get_level_path(Global.actual_level+1)
	Global.update_actual_level(Global.actual_level + 1)
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

func _on_restart_button_up():
	var path = Global.get_level_path(Global.actual_level)
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

func _on_menu_button_up():
	var path = "res://src/main_menu.tscn"
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

extends CanvasLayer

@onready var LabelTime = $Control/VBox/Time

var level_time = 0.0

func _ready():
	if Global.get_level_path(Global.actual_level+1) == "-1":
		$Control/VBox/Next.visible = false

func open_menu(time):
	$Control.visible = true
	var tmin = str(int(time / 60.0))
	var tseg = int(time) % 60
	if tseg < 10:
		tseg = "0" + str(tseg)
	else:
		tseg = str(tseg)
	$Control/VBox/Time.set_text("Total Time: " + tmin + ":" + tseg)

func _on_next_button_up():
	var path = Global.get_level_path(Global.actual_level+1)
	Global.actual_level += 1
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

func _on_restart_button_up():
	var path = Global.get_level_path(Global.actual_level)
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

func _on_menu_button_up():
	var path = ""
	get_tree().paused = false
	get_tree().change_scene_to_file(path)

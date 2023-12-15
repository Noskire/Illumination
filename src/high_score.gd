extends Control

func _ready():
	var labels = find_children("Lab*")
	var all_clear = true
	var alltime = 0.0
	for i in range(len(labels)):
		var num_level = "10"
		if i < 9:
			num_level = "0" + str(i+1)
		var best_time = Global.levels_time[i]
		alltime += best_time
		if best_time == 0:
			all_clear = false
			labels[i].set_text("Level " + num_level + ": --:--")
		else:
			var tmin = int(best_time / 60.0)
			if tmin < 10:
				tmin = "0" + str(tmin)
			else:
				tmin = str(tmin)
			var tseg = int(best_time) % 60
			if tseg < 10:
				tseg = "0" + str(tseg)
			else:
				tseg = str(tseg)
			labels[i].set_text("Level " + num_level + ": " + tmin + ":" + tseg)
	# END FOR
	if all_clear:
		$Grid/AllTimes.visible = true
		$Grid/Empty.visible = true
		var allmin = int(alltime / 60.0)
		if allmin < 10:
			allmin = "0" + str(allmin)
		else:
			allmin = str(allmin)
		var allseg = int(alltime) % 60
		if allseg < 10:
			allseg = "0" + str(allseg)
		else:
			allseg = str(allseg)
		$Grid/AllTimes.set_text("All Levels: " + allmin + ":" + allseg)

func _on_back_button_up():
	var path = "res://src/main_menu.tscn"
	get_tree().change_scene_to_file(path)

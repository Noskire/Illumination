extends Control

func text_to_acronym():
	var chars = 20
	var txt = "Laser Escape Dungeon"
	while true:
		await get_tree().create_timer(0.3).timeout
		chars -= 1
		if chars >= 14:
			txt = txt.substr(0, chars)
		elif chars > 7:
			txt = txt.substr(0, chars-1) + "D"
		elif chars > 2:
			txt = txt.substr(0, chars-2) + "ED"
		else:
			break
		$Label.set_text(txt)

func change_scene():
	var path = "res://src/main_menu.tscn"
	get_tree().change_scene_to_file(path)

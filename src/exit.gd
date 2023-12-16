extends Area2D

var level_time

func _ready():
	level_time = 0.0

func _process(delta):
	level_time += delta

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$AudioStreamPlayer.play()
		get_parent().find_child("HUD").open_menu(level_time)
		get_tree().paused = true

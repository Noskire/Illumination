extends Area2D

var crystals = []
var pressed = false
var color = "#ffff72"

func is_pressed():
	pressed = false
	for c in crystals:
		if c.color_active == color and c.powered_up:
			pressed = true

func _on_body_entered(body):
	if body.is_in_group("PowerUp"):
		crystals.append(body)
	is_pressed()

func _on_body_exited(body):
	for c in crystals:
		if body == c:
			crystals.erase(body)
			break
	is_pressed()

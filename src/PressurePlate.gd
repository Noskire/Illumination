extends Area2D

@export_enum("Blue", "Green", "Purple", "Yellow") var crystal_color: String = "Yellow"

var crystals = []
var pressed = false

func _ready():
	# Placeholder
	if crystal_color == "Blue":
		$Sprite2D.modulate = Color("#2d7fff")
	elif crystal_color == "Green":
		$Sprite2D.modulate = Color("#7fff7f")
	elif crystal_color == "Purple":
		$Sprite2D.modulate = Color("#7f7fff")
	elif crystal_color == "Yellow":
		$Sprite2D.modulate = Color("#ffff7f")

func is_pressed():
	pressed = false
	for c in crystals:
		if c.crystal_color == crystal_color and c.powered_up:
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

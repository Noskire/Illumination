extends Area2D

@export_enum("Blue", "Green", "Purple", "Yellow") var crystal_color: String = "Yellow"

var crystals = []
var pressed = false

func _ready():
	# Placeholder
	#if crystal_color == "Blue":
		#$CrystalSprite.frame = 1
	#elif crystal_color == "Green":
		#$CrystalSprite.frame = 2
	#elif crystal_color == "Purple":
		#$CrystalSprite.frame = 0
	#elif crystal_color == "Yellow":
		#$CrystalSprite.frame = 2
	pass

func is_pressed():
	pressed = false
	for c in crystals:
		if c.crystal_color == crystal_color and c.powered_up:
			pressed = true
			$AudioStreamPlayer.play(0.0)

func _on_body_entered(body):
	if body.is_in_group("PowerUp"):
		crystals.append(body)
		is_pressed()

func _on_body_exited(body):
	for c in crystals:
		if body == c:
			crystals.erase(body)
			is_pressed()
			break

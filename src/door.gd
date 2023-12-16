extends CharacterBody2D

@export_enum("Blue", "Green", "Purple", "Yellow") var crystal_color: String = "Yellow"
@export var pressure_plate: Area2D
@export var is_vdoor: bool = false

var is_open = false
var tween

func _ready():
	# Placeholder
	#if crystal_color == "Blue":
		#$Sprite2D.modulate = Color("#2d7fff")
	#elif crystal_color == "Green":
		#$Sprite2D.modulate = Color("#7fff7f")
	#elif crystal_color == "Purple":
		#$Sprite2D.modulate = Color("#7f7fff")
	#elif crystal_color == "Yellow":
		#$Sprite2D.modulate = Color("#ffff7f")
	pass

func _process(_delta):
	if not is_open and pressure_plate.pressed == true:
		open()
	elif is_open and pressure_plate.pressed == false:
		close()

func open():
	is_open = true
	if tween:
		tween.kill() # Abort the previous animation.
	tween = create_tween()
	# Interpolate until line width = 10
	if is_vdoor:
		$DoorL3.frame = 38
		$DoorR3.frame = 22
		tween.tween_property($DoorL2, "scale", Vector2(1, 0.5), 2)
		tween.parallel().tween_property($DoorL2, "position", Vector2(0, 24), 2)
		tween.parallel().tween_property($DoorL3, "position", Vector2(0, 24), 2)
		tween.parallel().tween_property($DoorR2, "scale", Vector2(1, 0.5), 2)
		tween.parallel().tween_property($DoorR2, "position", Vector2(0, 232), 2)
		tween.parallel().tween_property($DoorR3, "position", Vector2(0, 232), 2)
	else:
		$DoorL3.frame = 13
		$DoorR3.frame = 14
		tween.tween_property($DoorL2, "scale", Vector2(0.5, 1), 2)
		tween.parallel().tween_property($DoorL2, "position", Vector2(24, 0), 2)
		tween.parallel().tween_property($DoorL3, "position", Vector2(24, 0), 2)
		tween.parallel().tween_property($DoorR2, "scale", Vector2(0.5, 1), 2)
		tween.parallel().tween_property($DoorR2, "position", Vector2(232, 0), 2)
		tween.parallel().tween_property($DoorR3, "position", Vector2(232, 0), 2)
	#tween.tween_property($Sprite2D, "scale", Vector2(0.25, 0.1), 2)
	#tween.parallel().tween_property($CollisionShape2D.shape, "size", Vector2(32, 10), 2)
	$CollisionShape2D.set_disabled(true)

func close():
	is_open = false
	if tween:
		tween.kill() # Abort the previous animation.
	tween = create_tween()
	# Interpolate until line width = 10
	if is_vdoor:
		$DoorL3.frame = 36
		$DoorR3.frame = 20
		tween.tween_property($DoorL2, "scale", Vector2(1, 3.5), 2)
		tween.parallel().tween_property($DoorL2, "position", Vector2(0, 72), 2)
		tween.parallel().tween_property($DoorL3, "position", Vector2(0, 128), 2)
		tween.parallel().tween_property($DoorR2, "scale", Vector2(1, 3.5), 2)
		tween.parallel().tween_property($DoorR2, "position", Vector2(0, 184), 2)
		tween.parallel().tween_property($DoorR3, "position", Vector2(0, 128), 2)
	else:
		$DoorL3.frame = 3
		$DoorR3.frame = 4
		tween.tween_property($DoorL2, "scale", Vector2(3.5, 1), 2)
		tween.parallel().tween_property($DoorL2, "position", Vector2(72, 0), 2)
		tween.parallel().tween_property($DoorL3, "position", Vector2(128, 0), 2)
		tween.parallel().tween_property($DoorR2, "scale", Vector2(3.5, 1), 2)
		tween.parallel().tween_property($DoorR2, "position", Vector2(184, 0), 2)
		tween.parallel().tween_property($DoorR3, "position", Vector2(128, 0), 2)
	#tween.tween_property($Sprite2D, "scale", Vector2(2, 0.1), 2)
	#tween.parallel().tween_property($CollisionShape2D.shape, "size", Vector2(256, 10), 2)
	$CollisionShape2D.set_disabled(false)

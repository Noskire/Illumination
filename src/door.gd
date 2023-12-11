extends CharacterBody2D

@export var pressure_plate: Area2D

var is_open = false
var tween

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
	tween.tween_property($Sprite2D, "scale", Vector2(0.25, 0.1), 2)
	#tween.parallel().tween_property($CollisionShape2D.shape, "size", Vector2(32, 10), 2)
	$CollisionShape2D.set_disabled(true)

func close():
	is_open = false
	if tween:
		tween.kill() # Abort the previous animation.
	tween = create_tween()
	# Interpolate until line width = 10
	tween.tween_property($Sprite2D, "scale", Vector2(2, 0.1), 2)
	#tween.parallel().tween_property($CollisionShape2D.shape, "size", Vector2(256, 10), 2)
	$CollisionShape2D.set_disabled(false)

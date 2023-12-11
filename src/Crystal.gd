extends CharacterBody2D

@export var color_inactive = "#555500" # Initial color (placeholder)
@export var color_active = "#ffff72" # MUST BE the same as the Laser/Line default color
@export var time_needed = 3.0 # Time charging before be always up

var powered_up = false
var powering_up = false
var time

func _ready():
	$Sprite2D.set_modulate(Color(color_inactive)) # Set initial color
	time = 0

func _process(delta):
	if powering_up:
		time += delta
		if time >= time_needed:
			activate()
			set_process(false) # When powered up, won't need to execute the _process func anymore
	else:
		# Not powering, so set time to 0
		time = 0.0
	# Tint the node with a interpolation of color_inactive to color_active
	$Sprite2D.set_modulate(Color(color_inactive).lerp(Color(color_active), (time / time_needed)))

func powering(color, value):
	# Only start to power up if the line/color is equal to color_active
	if color.is_equal_approx(color_active) and value == true:
		powering_up = true
	else:
		powering_up = false

func activate():
	# Power up
	powered_up = true
	print("Powered Up!")

func move(vel): # Called by player node
	velocity = vel
	move_and_slide()

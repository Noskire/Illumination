extends CharacterBody2D

@export_enum("Blue", "Green", "Purple", "Yellow") var crystal_color: String = "Yellow"
@export var color_inactive = "#555555" # Initial color
@export var color_active = "#ffffff" # MUST BE the same as the Laser/Line default color
@export var time_needed = 4.0 # Time charging before be always up

var blue_path = "res://assets/Crystal_B.png"
var green_path = "res://assets/Crystal_G.png"
var purple_path = "res://assets/Crystal_P.png"
var yellow_path = "res://assets/Crystal_Y.png"

var charging_sfx = "res://assets/SFX/beam_cannon_charge.mp3"
var charged_sfx = "res://assets/SFX/turn_on.mp3"

var powered_up = false
@export var powering_up = false # Used to start the scene with a already powered crystal
var time

func _ready():
	if crystal_color == "Blue":
		$Sprite2D.frame = 1
	elif crystal_color == "Green":
		$Sprite2D.frame = 2
	elif crystal_color == "Purple":
		$Sprite2D.frame = 0
	elif crystal_color == "Yellow":
		$Sprite2D.frame = 2
	#$Sprite2D.set_modulate(Color(color_inactive)) # Set initial color
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
	#$Sprite2D.set_modulate(Color(color_inactive).lerp(Color(color_active), (time / time_needed)))

func powering(color, value):
	# Only start to power up if the line/color is equal to color_active
	#if color.is_equal_approx(color_active) and value == true:
	if color == crystal_color and value == true:
		powering_up = true
		if not powered_up:
			if $AudioStreamPlayer != null:
				$AudioStreamPlayer.play(0.0)
	else:
		if not powered_up:
			if $AudioStreamPlayer != null:
				$AudioStreamPlayer.stop()
		powering_up = false

func activate():
	# Power up
	if not powered_up:
		powered_up = true
		var pp = get_parent().find_children("Pressure*")
		for p in pp:
			p.is_pressed()
		if $AudioStreamPlayer != null:
			$AudioStreamPlayer.stop()
			$AudioStreamPlayer.set_stream(load(charged_sfx))
			$AudioStreamPlayer.play(0.0)

func move(vel): # Called by player node
	velocity = vel
	move_and_slide()

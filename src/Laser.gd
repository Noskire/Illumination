extends Node2D

@onready var ray = $RayCast2D
@onready var line = $Line2D

var tween
var is_casting = false
var max_length = 1000
var max_bounces = 10
var pu # Actual power_up being light up
var line_color

# Refraction vars
var crit_and # critical_angle ???
@export var ri = 0.750188 # refractive_indice = 1 / 1.333
# The refractive indices of air and water are approximately 1 and 1.333, respectively.
# sin(a2) = (n1 * sin(a1)) / n2 = ri * sin(a1)

func _ready():
	pu = null
	line_color = line.get_default_color()
	line.points[1] = Vector2.ZERO # "Erase" the line view in the editor

func _process(_delta):
	var mbl_pressed = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	line.clear_points() # Reset the line
	
	var powering_up = false
	if mbl_pressed: # If Mouse Button Left is pressed
		line.add_point(Vector2.ZERO) # The first point will be in the Line global position
		
		ray.global_position = line.global_position # Move the RayCast to the same position of the Line
		# Get the direction of line/ray pos to mouse click pos, normalize and multiply by max_length
		ray.target_position = (ray.get_global_mouse_position()-line.global_position).normalized() * max_length
		ray.force_raycast_update() # Force update
		
		var pt # End point of collision
		var coll # Raycast collider
		var normal # Raycast normal
		var prev = null # Collision of previous collider
		var bounces = 0 # Num. of bounces
		var collision_bits = 1 # layer 1 only (00001)
		while true:
			if not ray.is_colliding(): # If not colliding, traces a straight line and breaks
				pt = ray.global_position + ray.target_position
				line.add_point(line.to_local(pt))
				break
			
			# If colliding, get collider and collision point
			coll = ray.get_collider()
			pt = ray.get_collision_point()
			
			line.add_point(line.to_local(pt)) # Add a new point to the line
			
			if coll.is_in_group("PowerUp"): # If collides with a power up, energizes it and stops bouncing
				powering_up = true
				if pu != null: # If was powering a powerUp...
					if pu == coll: # If is the same, just breaks
						break
					# If not, stop powering the first one
					pu.powering(line_color, false)
				# Save the powerUp node and start powering it
				pu = coll
				pu.powering(line_color, true)
				break
			
			if not coll.is_in_group("Mirrors") and not coll.is_in_group("Refraction"): # If collides in a "wall" or something, breaks
				break
			
			if coll.is_in_group("Mirrors"): # If collides in a mirror, then bounces
				normal = ray.get_collision_normal() # Get collision normal
				if normal == Vector2.ZERO: # If normal equals 0, breaks
					break
				
				# If already disabled any collision (see below), enable it
				if prev != null:
					prev.collision_layer = collision_bits
					prev.collision_mask = collision_bits
				# Disable collision (Prevents to bounce inside collider)
				prev = coll
				prev.collision_layer = 0
				prev.collision_mask = 0
				
				# Moves RayCast to new position, bounces it and force update
				ray.global_position = pt
				ray.target_position = ray.target_position.bounce(normal)
				ray.force_raycast_update()
				
				bounces += 1 # Increment number of bounces
				if bounces >= max_bounces: # If hit max_bounces, breaks
					break
			if coll.is_in_group("Refraction"): # If collides in refraction body, then refracts
				normal = ray.get_collision_normal() # Get collision normal
				if normal == Vector2.ZERO: # If normal equals 0, breaks
					break
				
				# If already disabled any collision (see below), enable it
				if prev != null:
					prev.collision_layer = collision_bits
					prev.collision_mask = collision_bits
				# Disable collision (Prevents to bounce inside collider)
				prev = coll
				prev.collision_layer = 0
				prev.collision_mask = 0
				
				# sin(a2) = (n1 * sin(a1)) / n2 = ri * sin(a1)
				var ang = ray.target_position.angle_to(normal)
				var sina2 = ri * sin(ang)
				# Moves RayCast to new position, refracts it and force update
				ray.global_position = pt
				ray.target_position = ray.target_position.rotated(sina2) #ray.target_position.bounce(normal)
				ray.force_raycast_update()
				
				bounces += 1 # Increment number of bounces
				if bounces >= max_bounces: # If hit max_bounces, breaks
					break
		# END WHILE
		if prev != null: # If already disabled any collision, enable it
			prev.collision_layer = 1
			prev.collision_mask = 1
	# END IF
	# If not, stop powering the first one
	if pu != null and not powering_up: # If has a powerUp node saved, but it's not powering anymore
		pu.powering(line_color, false) # Stop powering
		pu = null
	set_is_casting(mbl_pressed) # Animate line via tween

# Animate line via tween
func set_is_casting(cast: bool):
	is_casting = cast
	# Calls corresponding function
	if is_casting:
		appear()
	else:
		disappear()

func appear():
	if tween:
		tween.kill() # Abort the previous animation.
	tween = create_tween()
	# Interpolate until line width = 10
	tween.tween_property(line, "width", 10, 0.2)

func disappear():
	if tween:
		tween.kill() # Abort the previous animation.
	tween = create_tween()
	# Interpolate until line width = 0
	tween.tween_property(line, "width", 0, 0.1)

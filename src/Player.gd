extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var ray = $RayCast2D

@export var speed = 300.0

func _physics_process(_delta):
	# Get direction and move
	velocity = get_direction() * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("pull"):
		ray.set_target_position(Vector2(50, 0))
	elif Input.is_action_just_released("pull"):
		ray.set_target_position(Vector2(40, 0))
	
	if ray.is_colliding():
		var coll = ray.get_collider()
		if coll.is_in_group("Movable"):
			coll.move(velocity)

func get_direction() -> Vector2:
	# Get player input
	var inp_r = Input.get_action_strength("move_right")
	var inp_l = Input.get_action_strength("move_left")
	var inp_d = Input.get_action_strength("move_down")
	var inp_u = Input.get_action_strength("move_up")
	var direction = Vector2(inp_r - inp_l, inp_d - inp_u)
	
	if direction.x < 0:
		sprite.set_flip_h(true)
	elif direction.x > 0:
		sprite.set_flip_h(false)
	
	var b = bigger(inp_r, inp_l, inp_d, inp_u)
	# if pressing 'pull', invert RayCast
	if b == 1:
		if Input.is_action_pressed("pull"):
			ray.set_rotation_degrees(180)
		else:
			ray.set_rotation_degrees(0)
	elif b == 2:
		if Input.is_action_pressed("pull"):
			ray.set_rotation_degrees(0)
		else:
			ray.set_rotation_degrees(180)
	elif b == 3:
		if Input.is_action_pressed("pull"):
			ray.set_rotation_degrees(-90)
		else:
			ray.set_rotation_degrees(90)
	elif b == 4:
		if Input.is_action_pressed("pull"):
			ray.set_rotation_degrees(90)
		else:
			ray.set_rotation_degrees(-90)
	
	return direction.normalized()

func bigger(a, b, c, d):
	if a == 0 and b == 0 and c == 0 and d == 0:
		return -1
	elif a > b and a > c and a > d:
		return 1
	elif b > c and b > d:
		return 2
	elif c > d:
		return 3
	else:
		return 4

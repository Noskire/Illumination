extends CharacterBody2D

func move(vel): # Called by player node
	velocity = vel
	move_and_slide()

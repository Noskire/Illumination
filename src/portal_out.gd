extends StaticBody2D

@onready var line = $Line2D

func _ready():
	line.points[1] = Vector2.ZERO # "Erase" the line view in the editor

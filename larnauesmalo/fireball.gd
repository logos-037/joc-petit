extends KinematicBody2D
var velocitat = Vector2(50, 0)
var damage = 400

func _process(delta):
	move_and_slide(velocitat)

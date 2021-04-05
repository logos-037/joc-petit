extends KinematicBody2D

var velocitat: Vector2
var gravetat = 1000

func _process(delta):
	velocitat.x = 0
	velocitat.y += gravetat * delta

	velocitat = move_and_slide(velocitat, Vector2.UP)
	
	anima(velocitat)

func anima(velocitat):
	if velocitat.x == 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("idle")

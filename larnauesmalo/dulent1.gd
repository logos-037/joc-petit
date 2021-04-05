extends KinematicBody2D

var velocitat: Vector2
var gravetat = 1000
var sentit = -1
var damage = 50

func _process(delta):
	velocitat.x = 100
	if is_on_wall():
		sentit *= -1
	velocitat.x *= sentit
	velocitat.y += gravetat * delta

	velocitat = move_and_slide(velocitat, Vector2.UP)
	
	anima(velocitat)

func anima(velocitat):
	if velocitat.x > 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("si")
	if velocitat.x < 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("si")

extends KinematicBody2D
var velocitat: Vector2
var gravetat = 1000
export var velocitat_max = 200
var vida := 1000
var mal = false
var malcounter = 30
var crouch_kick = false
var punch = false
var kick = false
var damage = 50

func _process(delta):
	velocitat.x = 0
	
	if Input.is_action_pressed("ui_right"):
		velocitat += Vector2.RIGHT * velocitat_max
	if Input.is_action_pressed("ui_left"):
		velocitat += Vector2.LEFT * velocitat_max
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocitat.y = -500
	velocitat.y += gravetat * delta
	velocitat = move_and_slide(velocitat, Vector2.UP)
	
	if Input.is_action_just_pressed("crouch-kick"):
		crouch_kick = true
	if Input.is_action_just_pressed("punch"):
		punch = true
	if Input.is_action_just_pressed("kick"):
		kick = true
	
	update_barravida(vida)
	anima(velocitat, mal, crouch_kick, punch, kick)
	
	malcounter -= 1
	if malcounter == 0:
		mal = false

func _on_Area2D_area_entered(area):
	vida -= area.get_parent().damage
	mal = true
	malcounter = 30

func update_barravida(vida):
	$barravida.value = vida

func anima(velocitat, mal, crouch_kick, punch, kick):
	
	if crouch_kick:
		$AnimatedSprite.play("crouch-kick")
	elif punch:
		$AnimatedSprite.play("punch")
	elif kick:
		$AnimatedSprite.play("kick")
	else:
	
		if velocitat.length() == 0:
			$AnimatedSprite.play("standing")
		
		if velocitat.x > 0:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("walking")
		if velocitat.x < 0:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("walking")
		if velocitat.y > 0 and not is_on_floor():
			$AnimatedSprite.play("fall")
		if velocitat.y < 0 and not is_on_floor():
			$AnimatedSprite.play("jump")
		
		if mal:
			$AnimatedSprite.play("hurt")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "crouch-kick":
		crouch_kick = false
	if $AnimatedSprite.animation == "punch":
		punch = false
	if $AnimatedSprite.animation == "kick":
		kick = false

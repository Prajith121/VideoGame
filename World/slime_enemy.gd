extends CharacterBody2D

func _physics_process(delta):
	if(velocity == Vector2(0,0)):
		$SlimeSprite.play("idle")
	else:
		$SlimeSprite.play("moving")
		if(velocity.x>0):
			$SlimeSprite.flip_h = false
		else:
			$SlimeSprite.flip_h = true
	move_and_slide()

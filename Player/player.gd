extends CharacterBody2D


const SPEED = 300.0
const MAXHEALTH = 100
var Health = 100; 
signal healthSignal(healthPercent)
var lastMoveDir = "right"
var idle: bool = true


func _physics_process(_delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	velocity = move(direction_x,direction_y)
	move_and_slide()
	
func move(x,y):
	$Player_Animations.flip_h = false
	var v : Vector2 = Vector2(x,y)
	if x>0 and y == 0:
		lastMoveDir = "right"
		$Player_Animations.play("walk_right")
	elif x<0 and y == 0:
		lastMoveDir = "left"
		$Player_Animations.flip_h = true
		$Player_Animations.play("walk_right")
		
	if y>0:
		lastMoveDir = "down"
		$Player_Animations.play("walk_down")
	elif y<0:
		lastMoveDir = "up"
		$Player_Animations.play("walk_up")
	if x== 0 and y == 0:
		if lastMoveDir == "right":
			$Player_Animations.play("idle_right")
		elif lastMoveDir == "up":
			$Player_Animations.play("idle_up")
		elif lastMoveDir == "down":
			$Player_Animations.play("idle_down")
		elif lastMoveDir == "left":
			$Player_Animations.flip_h = true
			$Player_Animations.play("idle_right")
			
	
	return (v.normalized() * SPEED)
			


func _on_health_signal(_health):
	pass # Replace with function body.

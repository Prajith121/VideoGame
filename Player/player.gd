extends CharacterBody2D


const SPEED = 200.0
const SPRINTSPEED = 400.0
const MAXHEALTH = 100
var SPRINTTIME = 200
var CANSPRINT = true
var stamina = 100;
var Health = 100; 
signal staminaSignal(stamina)
signal healthSignal(healthPercent)
var lastMoveDir = "right"
var idle: bool = true
func _ready():
	stamina = 100
	emit_signal("staminaSignal",stamina)
func _physics_process(_delta):
	if stamina > 0:
		CANSPRINT = true
		
	else: 
		CANSPRINT = false
	var mouse_left_down: bool = Input.is_action_pressed("SPRINT")
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if mouse_left_down:
		if CANSPRINT and (direction_x != 0 or direction_y != 0):
			if stamina< -0.2:
				stamina = -10
			else:
				stamina -= 0.1
				emit_signal("staminaSignal",stamina)
			velocity = move(direction_x,direction_y,SPRINTSPEED)
		else:
			if stamina != 100:
				stamina += 0.08
				emit_signal("staminaSignal",stamina)
			velocity = move(direction_x,direction_y,SPEED)
			
	else:
		if stamina != 100:
			stamina += 0.08
			emit_signal("staminaSignal",stamina)
		velocity = move(direction_x,direction_y,SPEED)
	move_and_slide()
	
func move(x,y,SPEED):
	$Player_Animations.flip_h = false
	var v : Vector2
	v.x = x
	v.y = y
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
			


func _on_health_signal(health):
	pass # Replace with function body.

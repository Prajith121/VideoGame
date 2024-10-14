extends CharacterBody2D


const SPEED = 200.0
const SPRINTSPEED = 400.0
var SPRINTTIME = 200
var CANSPRINT = true
@onready var stamina = get_node("Stamina")
@export var inv : Inv
var lastMoveDir = "right"
var idle: bool = true
func _ready():
	stamina.value = 100
func _physics_process(_delta):
	if stamina.value > 0:
		CANSPRINT = true
	
	else: 
		CANSPRINT = false
	var mouse_left_down: bool = Input.is_action_pressed("SPRINT")
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if mouse_left_down:
		if CANSPRINT:
			if stamina.value < -0.2:
				stamina.value = -10
			else:
				stamina.value -= 0.1
			velocity = move(direction_x,direction_y,SPRINTSPEED)
		else:
			if stamina.value != 100:
				stamina.value += 0.08
			velocity = move(direction_x,direction_y,SPEED)
			
	else:
		if stamina.value != 100:
			stamina.value += 0.08
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
			

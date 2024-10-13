extends CharacterBody2D


const SPEED = 200.0
const SPRINTSPEED = 400.0
var SPRINTTIME = 200
var CANSPRINT = true
@onready var stamina = get_parent().get_node("Stamina")
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
	var v : Vector2
	v.x = x
	v.y = y
	return (v.normalized() * SPEED)

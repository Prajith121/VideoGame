extends CharacterBody2D


const SPEED = 100.0
const SPRINTSPEED = 400.0
var SPRINTTIME = 200
var CANSPRINT = true
var mouse_left_down: bool = false
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if mouse_left_down:
		if CANSPRINT:
			$SprintTimer.set_paused(false)
			velocity = move(direction_x,direction_y,SPRINTSPEED)
		else:
			velocity = move(direction_x,direction_y,SPEED)
	else:
		$SprintTimer.set_paused(true)
		velocity = move(direction_x,direction_y,SPEED)
	move_and_slide()
func move(x,y,SPEED):
	var v : Vector2
	v.x = x
	v.y = y
	return (v.normalized() * SPEED)

func _input( event ):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			mouse_left_down = true
		elif event.button_index == 1 and not event.is_pressed():
			mouse_left_down = false


func _on_sprint_timer_timeout():
	CANSPRINT = false
	$Timer.start(-1)
	$SprintTimer.stop()

func _on_timer_timeout():
	CANSPRINT = true 
	$SprintTimer.start(-1)
	$Timer.stop()

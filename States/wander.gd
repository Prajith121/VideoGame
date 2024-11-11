extends State
class_name enemy_wander

@export var enemy : CharacterBody2D
@export var movespeed :=15
var move_direction : Vector2 
var wander_time : float 
func Enter():
	randomizeWander()

func Exit():
	pass
	
func Update(delta: float):
	if wander_time >0:
		wander_time-=delta
		PhysicsUpdate(delta)
	else:
		randomizeWander()
func PhysicsUpdate(_delta: float):
	if enemy:
		enemy.velocity = move_direction*movespeed

func randomizeWander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(0,3)

extends State
class_name enemy_wander

@export var enemy : CharacterBody2D
@export var movespeed :=150

const moveDirections : Array = [Vector2(1,0),Vector2(-1,0),Vector2(-1,-1),Vector2(0,1),Vector2(0,-1),Vector2(1,1)]
var move_direction : Vector2 
var wander_time : float 
var player : CharacterBody2D
func Enter():
	randomizeWander()
	player = get_tree().get_first_node_in_group("player")
	print("wander entered")
func Exit():
	pass
	
func Update(delta: float):
	if (player.global_position - enemy.global_position).length() < 100:
		emit_signal("transitioned",self,"enemy_follow")
	if wander_time >0:
		wander_time-=delta
	else:
		randomizeWander()
func PhysicsUpdate(_delta: float):
	if enemy:
		enemy.velocity = move_direction*movespeed

func randomizeWander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(0,3)

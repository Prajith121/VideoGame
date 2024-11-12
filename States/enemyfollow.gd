extends State
class_name enemy_follow

@export var enemy : CharacterBody2D
@export var movespeed :=150
const moveDirections : Array = [Vector2(1,0),Vector2(-1,0),Vector2(-1,-1),Vector2(0,1),Vector2(0,-1),Vector2(1,1)]
var direction : Vector2
var player : CharacterBody2D
var Velocity : Vector2

func Enter():
	player = get_tree().get_first_node_in_group("player")
	print("follow Entered")
	
func Update(delta : float):
	pass
func PhysicsUpdate(delta : float):
	direction = player.global_position - enemy.global_position
	direction = direction.normalized()
	if direction.length()>1000:
		emit_signal("transitioned",self,"enemy_wander")
	Velocity = findDirectionOfBestInterest(delta)
	enemy.velocity += Velocity
	
func Exit():
	pass

func findDirectionOfBestInterest(delta):
	var interestList = []
	for i in moveDirections:
		interestList.append(i.dot(direction))
		
	var desiredVelocity = Vector2(0,0)
	
			
	desiredVelocity = moveDirections[interestList.find(interestList.max())] * movespeed
	
	return (desiredVelocity-enemy.velocity)*delta   

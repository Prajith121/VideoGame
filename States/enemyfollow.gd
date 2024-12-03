extends State
class_name enemy_follow

@export var enemy : CharacterBody2D
@export var movespeed :=150
@export var Rays : Node
const moveDirections : Array = [Vector2(1,0),Vector2(-1,0),Vector2(-1,-1),Vector2(0,1),Vector2(0,-1),Vector2(1,1),Vector2(-1,1),Vector2(1,-1)]
var direction : Vector2
var player : CharacterBody2D
var Velocity : Vector2


#IMPORTANT
var interestList = [0,0,0,0,0,0,0,0]

func Enter():
	player = get_tree().get_first_node_in_group("slimetarget")
	print("follow Entered")
	for i in Rays.get_children():
		i.colliding.connect(danger)
		
func Update(delta : float):
	direction = player.global_position - enemy.global_position
	direction = direction.normalized()
	moveDirectionsInterest()
	if direction.length()>1000:
		emit_signal("transitioned",self,"enemy_wander")
func PhysicsUpdate(delta : float):
	
	Velocity = findDirectionOfBestInterest(delta)
	enemy.velocity += Velocity
	
func Exit():
	pass

func moveDirectionsInterest():
	for i in moveDirections.size():
		interestList[i]= moveDirections[i].dot(direction)
	
func findDirectionOfBestInterest(delta):
	var desiredVelocity = Vector2(0,0)
	desiredVelocity = moveDirections[interestList.find(interestList.max())] * movespeed
	return (desiredVelocity-enemy.velocity)*delta
	
func danger(rayCast,body):
	if body.is_in_group("slimetarget"):
		return 
	else:
		var vector1 = moveDirections[int(str(rayCast.name))]
		interestList[int(str(rayCast.name))] += -5
		interestList[moveDirections.find(Vector2(vector1.x*-1,vector1.y*-1))] += 0.01

		
		
		
	

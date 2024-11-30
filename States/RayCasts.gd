extends RayCast2D
class_name RayCastDetector

signal colliding(rayCast,body)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		emit_signal("colliding",self,get_collider())

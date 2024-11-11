extends Node

@export var initial_state : State 
var states : Dictionary = {}
var currentState : State 

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.connect("transitioned",on_child_transition)
		if initial_state:
			initial_state.Enter()
			currentState = initial_state
func _process(delta):
	if currentState:
		currentState.Update(delta)
func _physics_process(delta):
	if currentState:
		currentState.Update(delta)

func on_child_transition(state,new_state_name):
	if state != currentState:
		return
	var new_state = state.get(new_state_name.tolower())
	if !new_state:
		return
	if currentState:
		currentState.Exit()
	new_state.Enter()
	
	currentState = new_state 
		
	

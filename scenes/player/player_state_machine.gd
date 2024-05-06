class_name PlayerStateMachine extends State

var states: Array[State]
var previous_state: State
var current_state: State

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta):
	change_state(current_state.process(delta))

func _physics_process(delta):
	change_state(current_state.physics(delta))
	
func _unhandled_input(event):
	change_state(current_state.handle_input(event))
	
func initialize(player: Player) -> void:
	states = []
	
	for child in get_children():
		if child is State:
			states.append(child)
			
	if states.size() > 0:
		states[0].player = player
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(state: State) -> void:
	if state == null || state == current_state:
		return
	
	if current_state:	
		current_state.exit()
	
	previous_state = current_state
	current_state = state
	current_state.enter()

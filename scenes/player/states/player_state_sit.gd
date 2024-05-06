class_name PlayerStateSit extends State

@onready var idle_state: PlayerStateIdle = %IdleState
@onready var walk_state: PlayerStateWalk = %WalkState

# What happens when the player enters this state?
func enter() -> void:
	player.set_animation("down")
	
# What happens when the player exits this state?
func exit() -> void:
	pass

# What happens during the _process update in this state?
func process(_delta: float) -> State:
	if Input.is_action_just_released("down"):
		return idle_state
		
	return null
	
# What happens during the _physics_process update in this state?
func physics(delta: float) -> State:
	player.velocity.x = move_toward(player.velocity.x, 0, walk_state.move_speed / 10)
	
	return null

# What happens with input events in thie state?
func handle_input(event: InputEvent) -> State:
			
	return null

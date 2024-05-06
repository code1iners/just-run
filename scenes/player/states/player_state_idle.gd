class_name PlayerStateIdle extends State
 
@onready var walk_state: PlayerStateWalk = %WalkState
@onready var jump_state: PlayerStateJump = %JumpState
@onready var sit_state: PlayerStateSit = %SitState

# What happens when the player enters this state?
func enter() -> void:
	player.set_animation("idle")
	
# What happens when the player exits this state?
func exit() -> void:
	pass

# What happens during the _process update in this state?
func process(_delta: float) -> State:
	
	if player.direction != 0:
		return walk_state
		
	return null
	
# What happens during the _physics_process update in this state?
func physics(delta: float) -> State:
	player.velocity.x = move_toward(player.velocity.x, 0, walk_state.move_speed / 10)
	
	return null

# What happens with input events in thie state?
func handle_input(event: InputEvent) -> State:
	if event.is_action_pressed("up"):
		return jump_state
	
	#if event.is_action_pressed("down"):
		#return sit_state
		
	return null

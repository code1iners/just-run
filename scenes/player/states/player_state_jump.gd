class_name PlayerStateJump extends State

# TODO: Implement sit move state.

var isJumping: bool = false

@export var jump_velocity: float = -200.0

@onready var idle_state: PlayerStateIdle = %IdleState
@onready var walk_state: PlayerStateWalk = %WalkState

# What happens when the player enters this state?
func enter() -> void:
	player.set_animation("jump")
	
	isJumping = true
	
	player.animation.animation_finished.connect(func(): isJumping = false)
	
# What happens when the player exits this state?
func exit() -> void:
	pass

# What happens during the _process update in this state?
func process(_delta: float) -> State:
	if !isJumping:
		return idle_state if player.direction == 0 else walk_state
		
	return null
	
# What happens during the _physics_process update in this state?
func physics(_delta: float) -> State:
	if player.is_on_floor():
		player.velocity.y = jump_velocity
		
	return null

# What happens with input events in thie state?
func handle_input(_event: InputEvent) -> State:
	return null

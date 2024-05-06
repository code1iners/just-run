class_name PlayerStateWalk extends State

@export var base_move_speed: float = 150.0
@export var move_speed: float = base_move_speed
@export var jump_velocity: float = -300.0

@onready var idle_state: PlayerStateIdle = %IdleState
@onready var jump_state: PlayerStateJump = %JumpState
@onready var sit_state: PlayerStateSit = %SitState

# What happens when the player enters this state?
func enter() -> void:
	player.set_animation("walk")
	
# What happens when the player exits this state?
func exit() -> void:
	# Reset move speed
	move_speed = base_move_speed

# What happens during the _process update in this state?
func process(delta: float) -> State:
	if player.direction == 0:
		return idle_state
		
	return null
	
# What happens during the _physics_process update in this state?
func physics(delta: float) -> State:
	set_animation_direction()
	
	set_move_speed(delta)
	
	player.velocity.x = player.direction * move_speed
	
	return null

# What happens with input events in thie state?
func handle_input(event: InputEvent) -> State:
	if event.is_action_pressed("up"):
		return jump_state
	
	#if event.is_action_pressed("down"):
		#return sit_state
		
	return null

# Customs

func set_animation_direction() -> void:
	# Not moving
	if player.direction == 0:
		return
		
	player.animation.flip_h = player.direction == -1

func set_move_speed(delta: float) -> void:
	move_speed += delta * (move_speed / 10)

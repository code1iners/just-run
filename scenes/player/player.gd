class_name Player extends CharacterBody2D

@export var base_move_speed: float = 150.0
@export var move_speed: float = base_move_speed
@export var jump_velocity: float = -300.0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

var direction: int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	state_machine.initialize(self)

func _process(delta):
	
	set_animation()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity
	
	set_direction(delta)
	
	set_move_speed(delta)
	
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed / 12)

	move_and_slide()

func set_move_speed(delta: float) -> void:
	if !direction:
		move_speed = base_move_speed
	else:
		move_speed += delta * (move_speed / 10)

func set_direction(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	
	# Not moving
	if direction == 0:
		pass
		
	animation.flip_h = direction == -1  # direction이 -1이면 flip_h는 true, 아니면 false가 됩니다.


func set_animation() -> void:		
	if not is_on_floor():
		animation.play("jump")
	elif direction != 0:  # direction이 0이 아니면 캐릭터가 움직이고 있는 것으로 판단합니다.
		animation.play("walk")
	else:
		animation.play("idle")

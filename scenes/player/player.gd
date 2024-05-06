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
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	direction = Input.get_axis("left", "right")

func set_animation() -> void:
	match direction:
		-1:
			animation.flip_h = true
		1:
			animation.flip_h = false
	
	if not is_on_floor():
		animation.play("jump")
	else:
		match direction:
			-1, 1:
				animation.play("walk")
			_:
				if is_on_floor():
					animation.play("idle")
				

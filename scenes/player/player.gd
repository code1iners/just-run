class_name Player extends CharacterBody2D

var direction: int = 0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	state_machine.initialize(self)

func _process(_delta: float):
	set_direction()

func _physics_process(delta):
	
	set_vertical_gravity(delta)
		
	move_and_slide()

func set_direction() -> void:
	var new_direction = Input.get_axis("left", "right")
	direction = int(floor(new_direction))

func set_animation(state: String) -> void:
	animation.play(state)
		
func set_vertical_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

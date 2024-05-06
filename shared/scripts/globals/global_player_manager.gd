extends Node

const PLAYER = preload("res://scenes/player/player.tscn")

var player: Player
var is_player_spawned: bool = false

func _ready() -> void:
	add_player_instance()
	
	initialize()

func initialize() -> void:
	await get_tree().create_timer(0.2).timeout
	
	is_player_spawned = true
	
func add_player_instance() -> void:
	player = PLAYER.instantiate()
	
	add_child(player)

func set_player_position(position: Vector2) -> void:
	player.global_position = position

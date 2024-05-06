extends Node2D

func _ready() -> void:
	visible = false
	
	if not PlayerManager.is_player_spawned:
		PlayerManager.set_player_position(global_position)
		PlayerManager.is_player_spawned = true

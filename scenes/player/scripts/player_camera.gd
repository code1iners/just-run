extends Camera2D

func _ready() -> void:
	LevelManager.tilemap_bounds_changed.connect(set_limits)
	
	# Initialize.
	set_limits(LevelManager.current_tilemap_bounds)

func set_limits(bounds: Array[Vector2]) -> void:
	if bounds.size() == 0:
		return
		
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)

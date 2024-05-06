class_name LobbyLevelTileMap extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bounds = get_tilemap_bounds()
	
	LevelManager.set_tilemap_bounds(bounds)


func get_tilemap_bounds() -> Array[Vector2]:
	var bounds: Array[Vector2] = []
	
	var rect = get_used_rect()
	
	bounds.append(Vector2(rect.position * rendering_quadrant_size))
	bounds.append(Vector2(rect.end * rendering_quadrant_size))
	
	return bounds

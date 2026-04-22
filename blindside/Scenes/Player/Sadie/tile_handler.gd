extends Node2D
@onready var raycast : ShapeCast2D = $ShapeCast2D

func get_tile_below() -> String:
	if !raycast.is_colliding():
		return "null"
	return TilesetManager.get_tile_type(raycast.get_collision_point(0), TilesetManager.current_tilemap)
	

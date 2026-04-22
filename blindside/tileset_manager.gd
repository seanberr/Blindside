extends Node
var current_tilemap : TileMapLayer

func get_tile_type(coords: Vector2, layer: TileMapLayer) -> String:
	var local_pos = layer.to_local(coords)
	var tile_coords = layer.local_to_map(local_pos)
	var data = layer.get_cell_tile_data(tile_coords)
	
	if !data:
		return "null"
	if data.get_custom_data("is_rock"):
		return "rock"
	elif data.get_custom_data("is_grass"):
		return "grass"
	else:
		return "null"

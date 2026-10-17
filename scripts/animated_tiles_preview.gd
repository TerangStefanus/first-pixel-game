extends TileMapLayer

func _ready() -> void:
	for y in range(6, 17):
		for x in range(12, 30):
			if y in [10, 11, 12] or (x * 3 + y * 7) % 5 != 0:
				continue
			set_cell(Vector2i(x, y), 0, Vector2i.ZERO)

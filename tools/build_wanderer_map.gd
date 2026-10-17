extends SceneTree

const MAP_SIZE := Vector2i(56, 36)
const TILE_SIZE := 16
const SPAWN := Vector2(456, 312)

func _initialize() -> void:
	call_deferred("_build")

func _own(node: Node, parent: Node, scene: Node) -> void:
	parent.add_child(node, true)
	node.owner = scene

func _build() -> void:
	var scene := Node2D.new()
	scene.name = "WandererRunPreview"
	scene.y_sort_enabled = true
	scene.set_script(load("res://scripts/wanderer_map_preview.gd"))
	root.add_child(scene)
	var ground := TileMapLayer.new()
	ground.name = "Ground"
	ground.z_index = -3
	ground.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	ground.tile_set = load("res://resources/tilesets/ninja_ground.tres")
	_own(ground, scene, scene)
	var grass: Array[Vector2i] = []
	var dirt: Array[Vector2i] = []
	for y in range(MAP_SIZE.y):
		for x in range(MAP_SIZE.x):
			grass.append(Vector2i(x, y))
			ground.set_cell(Vector2i(x, y), 0, Vector2i(3, 12))
			# A broad loop, two straight crossing lanes, and a central clearing.
			var loop_lane := (x >= 7 and x <= 49 and (y >= 7 and y <= 11 or y >= 25 and y <= 29)) or (y >= 7 and y <= 29 and (x >= 7 and x <= 11 or x >= 45 and x <= 49))
			var cross_lane := (x >= 7 and x <= 49 and y >= 16 and y <= 20) or (y >= 7 and y <= 29 and x >= 26 and x <= 30)
			var clearing := Rect2i(23, 13, 11, 11).has_point(Vector2i(x, y))
			if loop_lane or cross_lane or clearing:
				dirt.append(Vector2i(x, y))
	ground.set_cells_terrain_connect(dirt, 0, 1)
	for cell in ground.get_used_cells():
		if not Rect2i(Vector2i.ZERO, MAP_SIZE).has_point(cell):
			ground.erase_cell(cell)
	# Keep the map deterministic while retaining subtle grass texture variation.
	var plain_grass := [Vector2i(0, 12), Vector2i(1, 12), Vector2i(2, 12), Vector2i(3, 12), Vector2i(4, 12)]
	for cell in ground.get_used_cells():
		var data := ground.get_cell_tile_data(cell)
		var atlas := ground.get_cell_atlas_coords(cell)
		if data.terrain == 0 and atlas in plain_grass + [Vector2i(2, 11), Vector2i(3, 11)]:
			var variant := 3 if (cell.x * 13 + cell.y * 7) % 11 > 2 else (cell.x + cell.y) % 5
			ground.set_cell(cell, 0, plain_grass[variant])
	var flowers := TileMapLayer.new()
	flowers.name = "Flowers"
	flowers.z_index = -2
	flowers.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	flowers.tile_set = load("res://resources/tilesets/ninja_flowers.tres")
	_own(flowers, scene, scene)
	for cell in grass:
		if cell.x < 4 or cell.y < 4 or cell.x > 51 or cell.y > 31:
			continue
		if ground.get_cell_tile_data(cell).terrain == 0 and (cell.x * 7 + cell.y * 11) % 41 == 0:
			flowers.set_cell(cell, 0, Vector2i.ZERO)
	# Trees and ruined stones provide landmarks and real collision to run around.
	for x in range(24, 897, 48):
		_prop(scene, Vector2(x, 42), true)
		_prop(scene, Vector2(x, 568), true)
	for y in range(90, 560, 48):
		_prop(scene, Vector2(22, y), true)
		_prop(scene, Vector2(874, y), true)
	for point in [Vector2(264, 248), Vector2(648, 248), Vector2(264, 376), Vector2(648, 376)]:
		_prop(scene, point, true)
	for point in [Vector2(320, 240), Vector2(592, 384)]:
		_prop(scene, point, false)
	var bounds := StaticBody2D.new()
	bounds.name = "MapBounds"
	_own(bounds, scene, scene)
	var walls := [Rect2(0, -16, 896, 16), Rect2(0, 576, 896, 16), Rect2(-16, 0, 16, 576), Rect2(896, 0, 16, 576)]
	for rect in walls:
		var collider := CollisionShape2D.new()
		var shape := RectangleShape2D.new()
		shape.size = rect.size
		collider.shape = shape
		collider.position = rect.get_center()
		_own(collider, bounds, scene)
	var player := (load("res://scenes/wanderer_64.tscn") as PackedScene).instantiate()
	player.name = "Wanderer64"
	player.position = SPAWN
	_own(player, scene, scene)
	var camera := Camera2D.new()
	camera.name = "Camera2D"
	camera.zoom = Vector2(3, 3)
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 896
	camera.limit_bottom = 576
	_own(camera, player, scene)
	var ui := CanvasLayer.new()
	ui.name = "UI"
	_own(ui, scene, scene)
	var panel := ColorRect.new()
	panel.name = "ControlBar"
	panel.color = Color(0.08, 0.10, 0.07, 0.9)
	panel.size = Vector2(640, 48)
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_own(panel, ui, scene)
	var label := Label.new()
	label.name = "Controls"
	label.position = Vector2(12, 5)
	label.text = "WASD / panah: jalan   |   Shift: lari   |   R: kembali ke tengah\nJalur melingkar, tanah & rumput — Ninja Adventure / Pixel-Boy & AAA (CC0)"
	label.add_theme_font_size_override("font_size", 13)
	_own(label, ui, scene)
	var packed := PackedScene.new()
	assert(packed.pack(scene) == OK)
	assert(ResourceSaver.save(packed, "res://scenes/previews/wanderer_run_preview.tscn") == OK)
	print("Built editable 56x36 terrain map, loop/crossing paths, trees, stones and collision.")
	quit()

func _prop(scene: Node, position: Vector2, tree: bool) -> void:
	var body := StaticBody2D.new()
	body.name = "Tree" if tree else "RuinedStone"
	body.position = position
	_own(body, scene, scene)
	var sprite := Sprite2D.new()
	sprite.texture = load("res://assets/tilesets/ninja_adventure/tileset_village_abandoned.png")
	sprite.region_enabled = true
	sprite.region_rect = Rect2(64, 96, 32, 48) if tree else Rect2(128, 48, 32, 32)
	sprite.position = Vector2(0, -22 if tree else -12)
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	_own(sprite, body, scene)
	var collider := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = Vector2(12, 8) if tree else Vector2(22, 12)
	collider.shape = shape
	collider.position = Vector2(0, -2)
	_own(collider, body, scene)

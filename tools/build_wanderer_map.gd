extends SceneTree

const MAP_SIZE := Vector2i(40, 28)
const TILE_SIZE := 32
const SPAWN := Vector2(656, 496)
const ASSET := "res://assets/tilesets/wildroot/"

func _initialize() -> void:
	call_deferred("_build")

func _own(node: Node, parent: Node, scene: Node) -> void:
	parent.add_child(node, true)
	node.owner = scene

func _is_path(cell: Vector2i) -> bool:
	for rect in [Rect2i(5, 5, 30, 3), Rect2i(5, 21, 30, 3), Rect2i(5, 5, 3, 19), Rect2i(32, 5, 3, 19), Rect2i(5, 14, 30, 3), Rect2i(19, 5, 3, 19), Rect2i(17, 12, 7, 7)]:
		if rect.has_point(cell):
			return true
	return false

func _build() -> void:
	var scene := Node2D.new()
	scene.name = "WandererRunPreview"
	scene.y_sort_enabled = true
	scene.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	scene.set_script(load("res://scripts/wanderer_map_preview.gd"))
	root.add_child(scene)
	var tiles := TileSet.new()
	tiles.tile_size = Vector2i(32, 32)
	var atlas := TileSetAtlasSource.new()
	atlas.texture = load(ASSET + "ground_32.png")
	atlas.texture_region_size = Vector2i(32, 32)
	for i in range(20):
		atlas.create_tile(Vector2i(i % 8, i / 8))
	tiles.add_source(atlas, 0)
	assert(ResourceSaver.save(tiles, "res://resources/tilesets/wildroot_ground.tres") == OK)
	tiles.take_over_path("res://resources/tilesets/wildroot_ground.tres")
	var ground := TileMapLayer.new()
	ground.name = "Ground"
	ground.z_index = -3
	ground.tile_set = tiles
	_own(ground, scene, scene)
	for y in range(MAP_SIZE.y):
		for x in range(MAP_SIZE.x):
			var cell := Vector2i(x, y)
			var index := 0 if (x * 13 + y * 7) % 9 < 6 else 1 + (x + y) % 3
			if _is_path(cell):
				var mask := 0
				for bit in range(4):
					var offset: Vector2i = [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT][bit]
					if _is_path(cell + offset):
						mask |= 1 << bit
				index = mask + 4
			ground.set_cell(cell, 0, Vector2i(index % 8, index / 8))
	# Irregular woodland edges leave room for both a canopy and a readable trunk.
	for i in range(18):
		var x := 44.0 + i * 70.0
		_prop(scene, Vector2(x, 134 + (i * 17) % 35), "oak_a" if i % 3 == 0 else "pine_a", Vector2(20, 13))
		_prop(scene, Vector2(x, 874 - (i * 11) % 29), "oak_b" if i % 2 == 0 else "pine_b", Vector2(20, 13))
	for i in range(8):
		_prop(scene, Vector2(42 + (i * 7) % 20, 235 + i * 72), "oak_b", Vector2(20, 13))
		_prop(scene, Vector2(1226 - (i * 9) % 18, 235 + i * 72), "oak_a", Vector2(20, 13))
	for point in [Vector2(390, 340), Vector2(920, 360), Vector2(396, 660), Vector2(902, 660)]:
		_prop(scene, point, "oak_a" if int(point.x) % 3 == 0 else "oak_b", Vector2(20, 13))
	for point in [Vector2(460, 330), Vector2(840, 380), Vector2(456, 620), Vector2(855, 610)]:
		_prop(scene, point, "rocks", Vector2(27, 13))
	for i in range(32):
		var point := Vector2(105 + (i * 173) % 1050, 190 + (i * 97) % 590)
		if _is_path(Vector2i(point / 32.0)):
			continue
		_prop(scene, point, "flower_bush" if i % 4 == 0 else "bush", Vector2.ZERO)
	for i in range(24):
		var point := Vector2(155 + (i * 113) % 960, 210 + (i * 83) % 490)
		if not _is_path(Vector2i(point / 32.0)):
			_prop(scene, point, "fern" if i % 3 == 0 else "flower", Vector2.ZERO)
	var bounds := StaticBody2D.new()
	bounds.name = "MapBounds"
	_own(bounds, scene, scene)
	for rect in [Rect2(0, -16, 1280, 16), Rect2(0, 896, 1280, 16), Rect2(-16, 0, 16, 896), Rect2(1280, 0, 16, 896)]:
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
	var shadow := Polygon2D.new()
	shadow.name = "FootShadow"
	shadow.z_index = -1
	shadow.color = Color(0.145, 0.137, 0.137, 0.25)
	shadow.polygon = PackedVector2Array([Vector2(-8, -1), Vector2(-6, -3), Vector2(5, -3), Vector2(8, -1), Vector2(6, 1), Vector2(-6, 1)])
	_own(shadow, player, scene)
	var camera := Camera2D.new()
	camera.name = "Camera2D"
	camera.zoom = Vector2.ONE
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = 1280
	camera.limit_bottom = 896
	_own(camera, player, scene)
	var ui := CanvasLayer.new()
	ui.name = "UI"
	_own(ui, scene, scene)
	var hud := Control.new()
	hud.name = "HUD"
	hud.set_script(load("res://scripts/wildroot_test_hud.gd"))
	_own(hud, ui, scene)
	var packed := PackedScene.new()
	assert(packed.pack(scene) == OK)
	assert(ResourceSaver.save(packed, "res://scenes/previews/wanderer_run_preview.tscn") == OK)
	print("Built Wildroot woodland: 32px terrain; native 110-128px trees; 1x camera; live movement HUD and minimap")
	quit()

func _prop(scene: Node, point: Vector2, asset: String, footprint: Vector2) -> void:
	var body := StaticBody2D.new() if footprint != Vector2.ZERO else Node2D.new()
	body.name = asset.to_pascal_case()
	body.position = point
	_own(body, scene, scene)
	var sprite := Sprite2D.new()
	sprite.texture = load(ASSET + asset + ".png")
	var tree := asset.begins_with("oak") or asset.begins_with("pine")
	if tree:
		body.set_script(load("res://scripts/wildroot_tree_occluder.gd"))
		body.set("canopy_half_width", 45.0 if asset.begins_with("oak") else 34.0)
	sprite.position = Vector2(0, -64) if tree else Vector2(0, -19)
	if asset == "flower":
		sprite.position = Vector2(0, -4)
	_own(sprite, body, scene)
	if footprint != Vector2.ZERO:
		var collider := CollisionShape2D.new()
		var shape := RectangleShape2D.new()
		shape.size = footprint
		collider.shape = shape
		collider.position = Vector2(0, -5)
		_own(collider, body, scene)

extends SceneTree

func _initialize() -> void:
	create_timer(10.0).timeout.connect(_timeout)
	call_deferred("_validate")

func _timeout() -> void:
	push_error("Map validation timed out before completion")
	quit(1)

func _step(frames: int) -> void:
	for tick in range(frames):
		await physics_frame

func _validate() -> void:
	var scene := (load("res://scenes/previews/wanderer_run_preview.tscn") as PackedScene).instantiate()
	root.add_child(scene)
	await _step(2)
	var ground := scene.get_node("Ground") as TileMapLayer
	print("Ground bounds: ", ground.get_used_rect(), "; cells: ", ground.get_used_cells().size())
	assert(ground.get_used_rect() == Rect2i(0, 0, 56, 36))
	assert(ground.get_used_cells().size() == 56 * 36)
	assert(ground.get_cell_tile_data(Vector2i(28, 19)).terrain == 1)
	assert(ground.get_cell_tile_data(Vector2i(18, 19)).terrain == 1)
	assert(ground.get_cell_tile_data(Vector2i(18, 14)).terrain == 0)
	var player := scene.get_node("Wanderer64") as CharacterBody2D
	for start in [Vector2(456, 312), Vector2(344, 232)]:
		player.position = start
		Input.action_press("move_right")
		Input.action_press("wanderer_run")
		await _step(15)
		Input.action_release("move_right")
		Input.action_release("wanderer_run")
		assert(player.position.x > start.x + 18.0, "Dirt and grass must both be walkable")
	player.position = Vector2(264, 278)
	Input.action_press("move_up")
	Input.action_press("wanderer_run")
	await _step(30)
	Input.action_release("move_up")
	assert(player.position.y >= 253 and player.position.y < 267, "Tree trunk must block movement")
	for sample in [[Vector2(8, 312), "move_left", 0], [Vector2(888, 312), "move_right", 1], [Vector2(432, 10), "move_up", 2], [Vector2(432, 566), "move_down", 3]]:
		player.position = sample[0]
		Input.action_press(sample[1])
		await _step(18)
		Input.action_release(sample[1])
		assert(player.position.x >= 4.9 and player.position.x <= 891.1)
		assert(player.position.y >= 7.9 and player.position.y <= 574.1)
	Input.action_release("wanderer_run")
	var reset := InputEventKey.new()
	reset.physical_keycode = KEY_R
	reset.pressed = true
	scene._unhandled_key_input(reset)
	assert(player.position == Vector2(456, 312))
	var camera := player.get_node("Camera2D") as Camera2D
	assert(camera.limit_left == 0 and camera.limit_right == 896)
	assert(camera.limit_top == 0 and camera.limit_bottom == 576)
	print("PASS: complete grass/dirt map; traversable lanes and grass; tree and four boundary collisions; reset and camera limits")
	scene.queue_free()
	quit()

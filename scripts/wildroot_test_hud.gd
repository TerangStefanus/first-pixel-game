extends Control

const INK := Color("252323")
const PAPER := Color("e6cf9a")
const MUTED := Color("b7a381")
const PANEL := Color("31382a")
const MAP_SIZE := Vector2(1280, 896)

var player: CharacterBody2D
var sprite: AnimatedSprite2D
var portrait: Texture2D = preload("res://assets/sprites/wanderer_64/base/idle_down.png")
var paths: Array[Vector2i] = []

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	player = get_node("../../Wanderer64")
	sprite = player.get_node("AnimatedSprite2D")
	var ground := get_node("../../Ground") as TileMapLayer
	for cell in ground.get_used_cells():
		if ground.get_cell_atlas_coords(cell).y > 0 or ground.get_cell_atlas_coords(cell).x >= 4:
			paths.append(cell)

func _process(_delta: float) -> void:
	queue_redraw()

func _panel(rect: Rect2) -> void:
	draw_rect(rect.grow(2), INK)
	draw_rect(rect, PANEL)
	draw_rect(rect, MUTED, false, 1)

func _text(at: Vector2, text: String, color: Color = PAPER, font_size: int = 11) -> void:
	draw_string(ThemeDB.fallback_font, at, text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, color)

func _draw() -> void:
	if not is_instance_valid(player):
		return
	_panel(Rect2(10, 10, 177, 54))
	draw_texture_rect(portrait, Rect2(10, 7, 64, 64), false)
	_text(Vector2(69, 26), "WANDERER", PAPER, 12)
	var state := "DIAM"
	if player.velocity.length() > 0.1:
		state = "LARI" if String(sprite.animation).begins_with("run_") else "JALAN"
	_text(Vector2(69, 42), state + "  /  " + str(roundi(player.velocity.length())) + " px/s", MUTED)
	_text(Vector2(69, 56), "Hutan uji  •  64 px", MUTED, 10)
	_panel(Rect2(510, 10, 120, 96))
	_text(Vector2(519, 24), "WILDROOT", PAPER, 12)
	var origin := Vector2(518, 31)
	var mini_size := Vector2(104, 68)
	draw_rect(Rect2(origin, mini_size), Color("68734b"))
	for cell in paths:
		draw_rect(Rect2(origin + Vector2(cell) * Vector2(2.6, 68.0 / 28.0), Vector2(2.7, 2.6)), Color("9e825d"))
	var point := origin + player.position / MAP_SIZE * mini_size
	draw_rect(Rect2(point - Vector2(2, 2), Vector2(5, 5)), INK)
	draw_rect(Rect2(point - Vector2.ONE, Vector2(3, 3)), PAPER)
	var camera := player.get_node("Camera2D") as Camera2D
	_panel(Rect2(10, 322, 620, 28))
	_text(Vector2(20, 340), "WASD  jalan     SHIFT  lari     R  reset     Z  zoom " + str(int(camera.zoom.x)) + "x     H  HUD", PAPER, 11)

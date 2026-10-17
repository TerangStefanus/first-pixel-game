extends StaticBody2D

@export var canopy_half_width: float = 45.0
var player: Node2D

func _process(_delta: float) -> void:
	if not is_instance_valid(player):
		player = get_parent().get_node_or_null("Wanderer64")
		return
	var relative := to_local(player.global_position)
	var behind := absf(relative.x) < canopy_half_width and relative.y < 0 and relative.y > -128
	$Sprite2D.self_modulate.a = 0.45 if behind else 1.0

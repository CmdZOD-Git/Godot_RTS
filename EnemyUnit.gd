extends Unit

@export var selection_visual : Sprite2D

@export var detect_range: float = 100

func _process(delta: float) -> void:
	_target_check()
	
	if target == null:
		for player in game_manager.player_units:
			if player == null:
				continue

			var distance = global_position.distance_to(player.global_position)
			
			if distance <= detect_range:
				set_target(player)

func toggle_selection_visual(toggle:bool) -> void:
	selection_visual.visible = toggle

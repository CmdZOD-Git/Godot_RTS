extends Unit
class_name  PlayerUnit
@export var selection_visual : Sprite2D

func toggle_selection_visual(toggle:bool) -> void:
	selection_visual.visible = toggle
	

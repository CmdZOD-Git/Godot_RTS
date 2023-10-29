extends Unit
class_name  PlayerUnit
@export var selection_visual : Sprite2D
@export var target_visual : Sprite2D

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if not target == null:
		toggle_target_visual(true)
		update_target_visual(target.global_position)
		
	elif target == null and not agent.is_navigation_finished():
		toggle_target_visual(true)
		update_target_visual(agent.target_position)
	else:
		toggle_target_visual(false)

func toggle_selection_visual(toggle:bool) -> void:
	selection_visual.visible = toggle
	
func toggle_target_visual(toggle:bool) -> void:
	target_visual.visible = toggle

func update_target_visual(target:Vector2) -> void:
	target_visual.global_position = target

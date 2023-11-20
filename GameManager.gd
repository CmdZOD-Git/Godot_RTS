extends Node2D

var selected_unit: Array[PlayerUnit]
var player_units: Array[Unit]
var enemy_units: Array[Unit]

signal update_unit_selection(selected_unit)

func _ready() -> void:
	get_node("%SelectionGUI").unit_selected.connect(_unit_selected)
	EventBus.unit_dead.connect(_unit_dead)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_try_select_unit()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_try_command_unit()
			
func _get_selected_unit():
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	var intersection: Array[Dictionary] = space.intersect_point(query, 1)
	
	if intersection.is_empty():
		return null
	else:
		return intersection[0].collider
		
func _try_select_unit():
	var unit = _get_selected_unit()
	
	if not unit == null and unit.is_player():
		_select_unit(unit)
		emit_signal("update_unit_selection", selected_unit)
	else:
		_unselect_unit()
	
func _select_unit(unit):
	_unselect_unit()
	selected_unit.append(unit)
	emit_signal("update_unit_selection", selected_unit)
	for item in selected_unit:
		item.toggle_selection_visual(true)

func _unselect_unit():
	if not selected_unit == null or selected_unit == []:
		for item in selected_unit:
			item.toggle_selection_visual(false)
	
	selected_unit.clear()
	emit_signal("update_unit_selection", selected_unit)
		
func _try_command_unit():
	if selected_unit == null or selected_unit == []:
		return
		
	var target = _get_selected_unit()

	if not target == null and target.is_player() == false:
		for item in selected_unit:
			item.set_target(target)
	else:
		for item in selected_unit:
			item.move_to_location(get_global_mouse_position())

func _unit_selected(unit_list:Array[Unit]):
	selected_unit.append_array(unit_list)
	emit_signal("update_unit_selection", selected_unit)
	for item in unit_list:
		item.toggle_selection_visual(true)

func _unit_dead(unit_reference:Unit):
	selected_unit = selected_unit.filter(func(a): return a != unit_reference)
	emit_signal("update_unit_selection", selected_unit)

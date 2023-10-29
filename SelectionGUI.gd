extends TextureRect

var position_on_mouse_down:Vector2 = Vector2.ZERO
var drag_on_mouse_down:Vector2 = Vector2.ZERO
var dragging:bool = false

var detected_bodies: Array[Node2D]

func _physics_process(delta: float) -> void:
	if dragging and visible:
		position = position_on_mouse_down
		size = drag_on_mouse_down - position_on_mouse_down

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not dragging:
			position_on_mouse_down = get_global_mouse_position()
			dragging = true
	
		if not event.pressed and dragging and visible:
			check_body(position_on_mouse_down, drag_on_mouse_down - position_on_mouse_down)
			position_on_mouse_down = Vector2.ZERO
			drag_on_mouse_down = Vector2.ZERO
			dragging = false
			visible = false
		
		if not event.pressed and dragging:
			dragging = false
			position_on_mouse_down = Vector2.ZERO
	
	if event is InputEventMouseMotion and dragging:
		drag_on_mouse_down = get_global_mouse_position()
		visible = true

func check_body(start:Vector2, size:Vector2) -> Array[Node2D]:
	var _rect = Rect2(start, size)
	var _temp:Array[Node] = get_tree().get_nodes_in_group("Unit")
	var _return_array:Array[Node2D] = []
	for actor in _temp:
		actor = actor as Node2D
		if _rect.has_point(actor.position):
			_return_array.append(actor)
	print(_return_array)
	return _return_array

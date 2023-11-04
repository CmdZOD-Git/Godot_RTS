extends TextureRect

var position_on_mouse_down:Vector2 = Vector2.ZERO
var drag_on_mouse_down:Vector2 = Vector2.ZERO
var current_box:Rect2
var dragging:bool = false

var detected_bodies: Array[Unit]

signal unit_selected(select_list:Array[Unit])

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if dragging and visible:
		current_box = compute_rect(position_on_mouse_down, drag_on_mouse_down)
		position = current_box.position
		size = current_box.size

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not dragging:
			position_on_mouse_down = get_global_mouse_position()
			dragging = true
	
		if not event.pressed and dragging and visible:
			detected_bodies = check_body(compute_rect(position_on_mouse_down, drag_on_mouse_down))
			unit_selected.emit(detected_bodies)
					
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

func check_body(rect:Rect2) -> Array[Unit]:
	var _temp:Array[Node] = get_tree().get_nodes_in_group("1")
	var _return_array:Array[Unit] = []
	for actor in _temp:
		actor = actor as Node2D
		if rect.has_point(actor.position):
			_return_array.append(actor as Unit)
	return _return_array

func compute_rect(point_a:Vector2, point_b:Vector2) -> Rect2:
	var start:Vector2
	var size:Vector2
	
	start.x = min(point_a.x, point_b.x)
	start.y = min(point_a.y, point_b.y)
	size.x = abs(point_a.x - point_b.x)
	size.y = abs(point_a.y - point_b.y)
	
	return Rect2(start, size)

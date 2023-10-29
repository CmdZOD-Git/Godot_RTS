extends TextureRect


@export var collision_shape: CollisionShape2D
@export var collision_area: Area2D
var collision_rectangle: RectangleShape2D = RectangleShape2D.new()

var position_on_mouse_down:Vector2 = Vector2.ZERO
var drag_on_mouse_down:Vector2 = Vector2.ZERO
var box: Vector2 = drag_on_mouse_down - position_on_mouse_down
var dragging:bool = false
var check_collision:bool = false

var detected_bodies: Array[Node2D]

func _ready() -> void:
	collision_shape.set_shape(collision_rectangle)
	collision_shape.set_deferred("disabled", false)

func _physics_process(delta: float) -> void:
	if dragging:
		global_position = position_on_mouse_down
		size = drag_on_mouse_down - position_on_mouse_down
	
	if check_collision:
		collision_shape.set_deferred("disabled", false)
		detected_bodies = collision_area.get_overlapping_bodies()
		print_debug(detected_bodies)
		var detected_areas = collision_area.get_overlapping_areas()
		print_debug(detected_areas)
		check_collision = false
		collision_shape.global_position = Vector2.ZERO
		collision_rectangle.size = Vector2.ZERO
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not dragging:
			position_on_mouse_down = event.global_position
			dragging = true
			visible = true
	
		if not event.pressed and dragging:
			collision_shape.global_position = position_on_mouse_down + 0.5 * box
			collision_rectangle.size = box
			check_collision = true
#			await get_tree().process_frame
			position_on_mouse_down = Vector2.ZERO
			drag_on_mouse_down = Vector2.ZERO
			dragging = false
			visible = false
	
	if event is InputEventMouseMotion and dragging:
		drag_on_mouse_down = event.global_position

extends Camera2D

var camera_move_speed: float = 500
var camera_zoom_speed: float = 2
var move_vector: Vector2 = Vector2.ZERO
var zoom_vector: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		move_vector.x = - 1
		
	if Input.is_action_pressed("ui_right"):
		move_vector.x = 1
		
	if Input.is_action_pressed("ui_down"):
		move_vector.y = 1
		
	if Input.is_action_pressed("ui_up"):
		move_vector.y = - 1
	
	if Input.is_action_pressed("ui_zoom_out"):
		zoom_vector = Vector2(-1, -1)
		
	if Input.is_action_pressed("ui_zoom_in"):
		zoom_vector = Vector2(1, 1)
		
	if not move_vector == Vector2.ZERO:
		position += move_vector.normalized() * camera_move_speed * delta * (1 / zoom.x)
		move_vector = Vector2.ZERO
		
	if not zoom_vector == Vector2.ZERO:
		zoom += zoom_vector * camera_zoom_speed * delta
		zoom = zoom.clamp(Vector2(0.75,0.75),Vector2(4,4))
		zoom_vector = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_zoom_out") and event is InputEventMouseButton:
#		Input.action_press("ui_zoom_out")
		zoom_vector = Vector2(-1, -1) * 3
	
	if event.is_action_pressed("ui_zoom_in") and event is InputEventMouseButton:
#		Input.action_press("ui_zoom_in")
		zoom_vector = Vector2(1, 1) * 3

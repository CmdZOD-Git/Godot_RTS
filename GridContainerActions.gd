extends GridContainer

@onready var main = get_node("/root/Main")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main.update_unit_selection.connect(_update_selection)
	
func _update_selection(unit_selection):	
	for item in get_children():
		item.queue_free()	
	
	for item in unit_selection:
		if item.action_list.size() == 0:
			continue
		
		for action in item.action_list:
			var add_item:TextureButton = TextureButton.new()
			
			add_item.texture_normal = action.icon
			add_item.size = Vector2(64,64)
			add_item.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT
			add_item.size_flags_horizontal = 3
			add_item.size_flags_vertical = 3
			
			mouse_filter = Control.MOUSE_FILTER_STOP
			
			add_item.button_down.connect(Callable(item, action.function_called))

			add_child(add_item)

extends GridContainer

@onready var main = get_node("/root/Main")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main.update_unit_selection.connect(_update_selection)
	
func _update_selection(unit_selection):
	
	for item in get_children():
		item.queue_free()	
	
	for item in unit_selection:
		var add_item:TextureRect = TextureRect.new()
		add_item.texture = item.sprite.texture
		add_item.size = Vector2(64,64)
		add_item.stretch_mode =TextureRect.STRETCH_KEEP_ASPECT
		add_item.size_flags_horizontal = 3
		add_item.size_flags_vertical = 3
		add_child(add_item)

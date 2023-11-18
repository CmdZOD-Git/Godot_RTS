extends Marker2D

@export var Spawn:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawned_unit = Spawn.instantiate()
	spawned_unit.transform = self.transform
	await get_tree().process_frame
	add_sibling(spawned_unit)
	self.queue_free()
	

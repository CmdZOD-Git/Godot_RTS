extends VBoxContainer
@export var text0:Label
@export var text1:Label
@export var text2:Label
@export var text3:Label
@export var text4:Label
@export var text5:Label
@export var text6:Label

func _physics_process(delta: float) -> void:
	text0.text = str(get_local_mouse_position())
	text1.text = str(get_global_mouse_position())

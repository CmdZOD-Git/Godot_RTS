extends Control

var attack_move_command:bool
@export var target_sprite:Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_sprite.set_deferred("visible", false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if attack_move_command == true:
		target_sprite.set_deferred("visible", true)
		target_sprite.global_position = get_global_mouse_position()
	else:
		target_sprite.set_deferred("visible", false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("control_key"):
		attack_move_command = true
		EventBus.emit_signal("attack_move", true)
		
	if event.is_action_released("control_key"):
		attack_move_command = false
		EventBus.emit_signal("attack_move", false)

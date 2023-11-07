extends Action

@export var transform_target:PackedScene

func _init() -> void:
	verb = "Transform"

func fire(base:Unit, target:Unit) -> void:
	var temp_host:Unit
	temp_host = base
	base = transform_target.instantiate() as Unit
	base.health = clamp(temp_host.health,0, base.health_max)

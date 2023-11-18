extends CharacterBody2D

class_name Projectile

var target:CharacterBody2D
var damage:float
var move_speed:float
var hit_effect:PackedScene

func _physics_process(delta: float) -> void:
	if target == null:
		queue_free()
		return

	if global_position.distance_to(target.global_position) <= 4:
		target.add_child(hit_effect.instantiate())
		target.take_damage(damage)
		queue_free()
	else:	
		var direction:Vector2 = global_position.direction_to(target.global_position)
		rotation = direction.angle() + PI/2
		velocity = direction * move_speed
		move_and_slide()

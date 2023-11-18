extends CharacterBody2D

class_name Projectile

var target:CharacterBody2D
var damage:float
var move_speed:float
var hit_effect:PackedScene
var area_of_effect:float

func _physics_process(delta: float) -> void:
	if target == null:
		queue_free()
		return

	if global_position.distance_to(target.global_position) <= 4:
		if area_of_effect <= 0:
			target.add_child(hit_effect.instantiate())
			target.take_damage(damage)
			queue_free()
		else:
			var hit_list:Array = get_tree().get_nodes_in_group("2")
			for item in hit_list:
				if item.global_position.distance_squared_to(global_position) <= area_of_effect ** 2:
					item.add_child(hit_effect.instantiate())
					item.take_damage(damage)
			queue_free()
				
	else:	
		var direction:Vector2 = global_position.direction_to(target.global_position)
		rotation = direction.angle() + PI/2
		velocity = direction * move_speed
		move_and_slide()

# Important things i learned with the Zenva tutorial

1. Calling the world2D to get what's under my mouse

``` GDScript
func _get_selected_unit():
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	var intersection: Array[Dictionary] = space.intersect_point(query, 1)

	if intersection.is_empty():
		return null
	else:
		return intersection[0].collider
```

2. Setting up a navigation agent
    + Just add a navigation node
    + Setup navigation region
    + get direction from NavigationLink2D.get_next_path_position()
    + move and slide !

3. Get global time

``` GDSCript
var current_time = Time.get_unix_time_from_system()
	if current_time - last_attack_time < attack_rate:
	return
```

4. Use modulate and await + in-line timer

```
sprite.modulate = Color.RED
await get_tree().create_timer(0.1).timeout
sprite.modulate = Color.WHITE
```

5. Make a selection visual with a simple selection sprite

# What i want to do next

## SPRINT 1
1. DONE Expend selection with a a target indicator
2. Healtbar
3. area selection with mouse as a first step to multiple unit game

# If i were to start from 0
+ Put game_manager in a generic 2D node above the tilemap
+ Make a more robust generic Unit class
+ Be really carefull with overiding _ready and process... or use super

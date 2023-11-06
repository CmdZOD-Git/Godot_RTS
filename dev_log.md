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

``` GDScript
sprite.modulate = Color.RED
await get_tree().create_timer(0.1).timeout
sprite.modulate = Color.WHITE
```

5. Make a selection visual with a simple selection sprite

6. Basic event listener for mouse press

``` GDSCript
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_try_select_unit()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_try_command_unit()
```

# What i want to do next

## If i were to start from 0
+ Put game_manager in a generic 2D node above the tilemap
+ Make a more robust generic Unit class
	 - Be really carefull with overiding _ready and process... or use super

## SPRINT 1 - DONE
1. DONE Switch from navigation region to tileset based navigation (PS : you can use both together !)
	- Only needed to add navigation to the Tileset ressource
2. DONE Expend selection with a a target indicator
	- Added logic to Player Unit
3. DONE Healtbar
4. DONE area selection with mouse as a first step to multiple unit game
	- DONE Getting the selection area to work
	- DONE Getting selection area to work in all direction -> easier than i thought
	- DONE (ugly but done) Implement logic to select multiple units

## SPRINT 2
1. DONE Main Event Bus
2. DONE Camera Move and Zoom in/out
3. Health regen & associated particles
4. Hit impact
5. Basic UI for selected unit & action box
6. Transform UNit
7. Ranged unit
8. Ranged area attack
9. Auto attack

## SPRINT 3
1. Attack Move
2. XP System
3. Barracks
4. UI for Ressources & Time
5. Mission logic
6. Mission select screen

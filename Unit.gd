extends CharacterBody2D

class_name Unit

@export var health:float = 100.0
@export var health_max:float = 100.0
@export var health_regen:float = 1.0
@export var damage:int = 20

@export var move_speed:float = 50
@export var attack_range:float = 20
@export var attack_rate:float = 0.5

var last_attack_time:float

var target:CharacterBody2D

@export var agent: NavigationAgent2D
@export var sprite: Sprite2D
@export var collision: CollisionShape2D
@export var hp_bar: ProgressBar
@export var particle_health: GPUParticles2D
@export var attack_animation_effect:PackedScene

@onready var game_manager: Node = get_node("/root/Main")

@export var action_list: Array[ActionVerb]

@export var team:int = 1

func _ready() -> void:
	add_to_group("Unit")

	if is_player():
		game_manager.player_units.append(self)
	else:
		game_manager.enemy_units.append(self)
		
	update_hp_bar()

func _physics_process(delta: float) -> void:
	if health < health_max:
		health += health_regen * delta
		health = clampf(health, 0, health_max)
		particle_health.emitting = true
		update_hp_bar()
	else:
		particle_health.emitting = false
	
	if agent.is_navigation_finished():
		return
	
	var direction = global_position.direction_to(agent.get_next_path_position())
	velocity = direction * move_speed
	move_and_slide()

func _process(delta: float) -> void:
	_target_check()

func is_player() -> bool:
	if team == 1:
		return true
	else:
		return false

func move_to_location (location):
	target = null
	agent.target_position = location

func set_target(new_target):
	target = new_target

func _target_check() -> void:
	if target == null:
		return
		
	var distance = global_position.distance_to(target.global_position)
	
	if distance <= attack_range:
		agent.target_position = global_position
		_try_attack_target(target)
	else:
		agent.target_position = target.global_position
	

func _try_attack_target(target):
	var current_time = Time.get_unix_time_from_system()
	if current_time - last_attack_time < attack_rate:
		return

	target.add_child(attack_animation_effect.instantiate())
	target.take_damage(damage)	
	last_attack_time = current_time

func take_damage (damage_to_take) -> void:
	health -= damage_to_take
	update_hp_bar()

	if health <= 0:
		EventBus.emit_signal("unit_dead", self)
		queue_free()
		
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

func update_hp_bar() -> void:
	var ratio:float = 100 * health / health_max
	hp_bar.set_value(ratio)

func action_transform_self(target_unit_path:String = "res://PlayerUnitHeavy.tscn"):
	var target_item: Unit = load(target_unit_path).instantiate()
	var selected_unit = game_manager.selected_unit
	target_item.transform = transform
	target_item.health = health
	target_item.target = target
	target_item.agent.target_position = agent.target_position
	target_item.last_attack_time = last_attack_time
	target_item.team = team
	add_sibling(target_item)
	selected_unit.erase(self)
	selected_unit.append(target_item)
	game_manager.emit_signal("update_unit_selection", selected_unit)
	
	self.queue_free()

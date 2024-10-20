class_name WeepingAngelEnemy
extends CharacterBody2D

var player: Player
@onready var navigation_timer: Timer = $NavigationTimer
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	navigation_timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta: float) -> void:
	if is_player_looking():
		move_towards_player()

func is_player_looking():
	# calculate angle from where player is looking to where the enemy is
	# you should also add some "is on screen" logic
	# you should also think about adding raycasting in order to determine if something is inbetween
	var player_facing_direction: Vector2 = Vector2(1,0).rotated(player.rotation).normalized()
	var player_to_enemy: Vector2 = player.global_position.direction_to(global_position).normalized()
	var dot_product: float = player_to_enemy.dot(player_facing_direction)
	# Currently this is set to 180 degrees. Think about fine tuning this to be within a a tighter range
	if dot_product > 0:
		if is_in_line_of_sight():
			return null
	move_towards_player()
	

func move_towards_player() -> void:
	var direction = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	velocity = direction * 100
	move_and_slide()


func is_in_line_of_sight():
	var space_state = get_world_2d().direct_space_state
	var line_of_sight_query = PhysicsRayQueryParameters2D.create(global_position, player.global_position)
	var result: Dictionary = space_state.intersect_ray(line_of_sight_query)
	if result:
		if result.has("collider"):
			if is_instance_of(result["collider"], TileMap):
				return false
	return true

func create_path_to_player():
	navigation_agent_2d.target_position = player.global_position

func _on_timer_timeout():
	create_path_to_player()

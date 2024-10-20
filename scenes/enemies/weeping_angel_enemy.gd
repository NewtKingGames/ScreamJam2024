class_name WeepingAngelEnemy
extends CharacterBody2D

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	if is_player_looking():
		move_towards_player()

func is_player_looking():
	# calculate angle from where player is looking to where the enemy is
	# you should also add some "is on screen" logic
	# you should also think about adding raycasting in order to determine if something is inbetween
	var player_facing_direction: Vector2 = Vector2(1,0).rotated(player.rotation).normalized()
	#print(player_facing_direction)
	var player_to_enemy: Vector2 = player.global_position.direction_to(global_position).normalized()
	#print(player_to_enemy)
	#print("dot product")
	#print(player_to_enemy.dot(player_facing_direction))
	var dot_product: float = player_to_enemy.dot(player_facing_direction)
	# Currently this is set to 180 degrees. Think about fine tuning this to be within a a tighter range
	if dot_product > 0:
		if is_in_line_of_sight():
			return null
	move_towards_player()
	

func move_towards_player() -> void:
	velocity = global_position.direction_to(player.global_position) * 100
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

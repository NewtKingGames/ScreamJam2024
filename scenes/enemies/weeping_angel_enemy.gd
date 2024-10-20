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
	var player_facing_direction: Vector2 = Vector2(1,0).rotated(player.rotation)
	var angle_to_enemy: float = player_facing_direction.angle_to(position)
	print(angle_to_enemy)
	if angle_to_enemy < 60.0:
		return true

func move_towards_player() -> void:
	print("moving towards player")

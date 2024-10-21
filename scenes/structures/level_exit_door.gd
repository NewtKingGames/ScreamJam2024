class_name LevelExitDoor
extends Node2D

# The idea for this class is to be the parent of level exit locks which will be lights
# which when activated will light up.

# The parent component will determine the number of locks it has dynamically by reading it's children

@onready var big_door: Door = $BigDoor
@onready var togglable_light: TogglableLight = $TogglableLight

var num_locks: int = 0
var num_unlocked_locks: int = 0

func _ready() -> void:
	for child in get_children():
		if child is LevelExitDoorLock:
			num_locks +=1
			child.lock_unlocked.connect(_on_lock_unlocked)


func _on_lock_unlocked(lock: LevelExitDoorLock) -> void:
	num_unlocked_locks += 1
	if num_unlocked_locks == num_locks:
		big_door.open()
		togglable_light.turn_on()

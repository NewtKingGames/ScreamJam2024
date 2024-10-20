extends PointLight2D


var max_light_energy: float = randf_range(0.25, 0.35)
var min_light_energy: float = randf_range(0.05, 0.15)
var initial_light_energy: float = randf_range(min_light_energy, max_light_energy)

func _ready():
	self.energy = initial_light_energy
	animate_light()

func animate_light():
	var light_flicker_tween: Tween = create_tween().set_loops()
	light_flicker_tween.tween_property(self, "energy", randf_range(0.03, 0.2), randf_range(0.25, 1))
	light_flicker_tween.tween_property(self, "energy", randf_range(0.3, 0.4), randf_range(0.25, 1))

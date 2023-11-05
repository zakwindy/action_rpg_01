extends Control

var max_hearts = 4:
	get:
		return max_hearts
	set(value):
		max_hearts = max(value, 1)

var hearts = 4: set = assign_hearts

@onready var label = $Label

func assign_hearts(value):
	hearts = clamp(value, 0, max_hearts)

func _ready():
	var stats = PlayerStats
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	stats.health_changed.connect(assign_hearts)

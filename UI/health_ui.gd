extends Control

@onready var heartUIFull = $HeartUIFull
@onready var heartUIEmpty = $HeartUIEmpty

var max_hearts = 4: set = assign_max_hearts

var hearts = 4: set = assign_hearts

func assign_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.size.x = hearts * 15


func assign_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.size.x = max_hearts * 15


func _ready():
	var stats = PlayerStats
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	stats.health_changed.connect(assign_hearts)
	stats.max_health_changed.connect(assign_max_hearts)

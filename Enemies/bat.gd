extends CharacterBody2D

const FRICTION = 200
const KNOCKBACK = 120

@onready var stats = $Stats

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide() 


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	velocity = area.knockback_vector * KNOCKBACK


func _on_stats_no_health():
	queue_free()

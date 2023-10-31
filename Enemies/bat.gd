extends CharacterBody2D

const EnemyDeathEffect = preload("res://Effects/enemy_death_effect.tscn")

@export var ACCELERATION = 300
@export var MAX_SPEED = 50
@export var FRICTION = 200
@export var KNOCKBACK = 120

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = CHASE

@onready var stats = $Stats
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var sprite = $AnimatedSprite2D
@onready var hurtbox = $Hurtbox

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		WANDER:
			pass
		
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			sprite.flip_h = velocity.x < 0
	
	move_and_slide() 


func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	velocity = area.knockback_vector * KNOCKBACK
	hurtbox.create_hit_effect()


func _on_stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

extends Area2D

const HitEffect = preload("res://Effects/hit_effect.tscn")

func create_hit_effect(area):
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

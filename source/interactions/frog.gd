class_name Frog
extends Node3D

@export var animated_sprite: AnimatedSprite3D

func play_jump_anim():
	animated_sprite.play("jump")
	animated_sprite.animation_finished.connect(_on_jump_finished, CONNECT_ONE_SHOT)

func _on_jump_finished() -> void:
	animated_sprite.play("default")

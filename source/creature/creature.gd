class_name Creature extends Node3D

@export var approach_sound: AudioStream
@export var attack_sound: AudioStream
@export var time_seg: float

@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
@onready var stream_player: AudioStreamPlayer = $AudioStreamPlayer


func disappear() -> void:
	var dis_tween: Tween = create_tween()
	
	dis_tween.tween_property(sprite, 'modulate:a', 0, 1.0).set_ease(Tween.EASE_OUT)
	dis_tween.finished.connect(queue_free.call_deferred)
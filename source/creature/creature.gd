class_name Creature extends Node3D

@export var approach_sound: AudioStream
@export var attack_sound: AudioStream
@export var time_seg: float

@onready var stream_player: AudioStreamPlayer = $AudioStreamPlayer

var tween: Tween

func _ready() -> void:
	_reset_sound()
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _reset_sound()
	
func _reset_sound() -> void:
	if tween != null:
		tween.stop()
		tween = null
		
	stream_player.stream = approach_sound
	stream_player.play()
	var bus_index := AudioServer.get_bus_index('Creature')
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_method(
		func(value):
			AudioServer.set_bus_volume_db(bus_index, value),
		-60.0,
		0.0,
		time_seg
	)
	tween.finished.connect(
		func():
			stream_player.stream = attack_sound
			stream_player.play()
			EventBusSingleton.send_event(GameOverEvent.new())
	)


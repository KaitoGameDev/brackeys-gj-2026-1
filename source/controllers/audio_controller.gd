class_name AudioController extends Node

@export var bgms: Array[AudioStream] = []

@onready var bgm_players: Array[AudioStreamPlayer] = [$BGM_Player_1, $BGM_Player_2]

var _current_player_index := 0

func _ready() -> void:
	bgm_players[_current_player_index].stream = bgms.pop_front()
	bgm_players[_current_player_index].play()
	
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is PlayerChangedFloorEvent: return _on_player_changed_floor()
	

func _on_player_changed_floor() -> void:
	mount_next()
	
	
func mount_next() -> void:
	var _next_player := 1 if _current_player_index == 0 else 0
	bgm_players[_next_player].stream = bgms.pop_front()
	var out_bus_index := _current_player_index + 1
	var in_bus_index := _next_player + 1
	var start_db := AudioServer.get_bus_volume_db(out_bus_index)
	bgm_players[_next_player].play()
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_method(
		func(value):
			AudioServer.set_bus_volume_db(out_bus_index, value),
		start_db,
		-60.0,
		5.0
	)
	tween.tween_method(
		func(value):
			AudioServer.set_bus_volume_db(in_bus_index, value),
		-60.0,
		0.0,
		5.0
	)
	tween.finished.connect(
		func():
			bgm_players[_current_player_index].stop()
			_current_player_index = _next_player
	)

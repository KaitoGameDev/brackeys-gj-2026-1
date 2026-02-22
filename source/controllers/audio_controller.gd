class_name AudioController extends Node

@export var bgms: Array[AudioStream] = []
@export var main_bgm: AudioStream
@export var main_sfx: AudioStream

var sfxs: Dictionary[String, AudioStream] = {
	"key_item": preload("res://assets/audio/sfxs/key_item.wav"),
	"solved_puzzle": preload("res://assets/audio/sfxs/solved_puzzle.wav"),
	"hit_statue_1": preload("res://assets/audio/sfxs/hit_statue_1.wav"),
	"hit_statue_2": preload("res://assets/audio/sfxs/hit_statue_2.wav"),
}

@export var puzzle_sfx: AudioStream 

@onready var sfxs_player: Array[AudioStreamPlayer] = [$SFX, $SFX2, $SFX3, $SFX4, $SFX5]
@onready var bgm_players: Array[AudioStreamPlayer] = [$BGM_1, $BGM_2]

var _current_player_index := 0
var _current_sfx_player_index := 0

func _ready() -> void:
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is PlaySfxEvent: return _play_sfx_event(event)
	if event is GameInitiatedEvent: return _game_initiated()
	if event is GameStartedEvent: return _started_game()
	if event is PlayerChangedFloorEvent: return _on_player_changed_floor()
	
func _play_sfx_event(event: PlaySfxEvent) -> void:
	_current_sfx_player_index += 1
	if _current_sfx_player_index == 5:
		_current_sfx_player_index = 0
	sfxs_player[_current_sfx_player_index].stream = sfxs[event.sfx_name]
	sfxs_player[_current_sfx_player_index].play()
	if event.should_stop_after > 0:
		var current_player := sfxs_player[_current_sfx_player_index]
		get_tree().create_timer(event.should_stop_after).timeout.connect(
			func():
				current_player.stop()
		)
	
func _game_initiated() -> void:
	bgm_players[0].stream = main_bgm
	bgm_players[0].volume_db = -15.0
	bgm_players[1].stream = main_sfx
	bgm_players[1].volume_db = -20.0
	bgm_players[0].play()
	bgm_players[1].play()
	
func _started_game() -> void:
	for player in bgm_players:
		player.stop()

	bgm_players[0].stream = bgms.pop_front()
	bgm_players[0].play()

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

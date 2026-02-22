class_name CenterRoom extends Node3D

@export var player_pivot: Node3D

var sections: Array[Node3D] = []

func _ready() -> void:
	EventBusSingleton.on_event.connect(_on_event)
	_load_spots()

func _load_spots() -> void:
	for section in get_children():
		sections.push_back(section)

func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _move_to_next_spot()

func _on_movement_end() -> void:
	EventBusSingleton.send_event(PlayerEndMovementEvent.new())
	sections[0].position.y = 0

func _move_to_next_spot() -> void:
	EventBusSingleton.send_event(PlaySfxEvent.create('footsteps', 2.0))
	var tween := create_tween()
	tween.tween_property(player_pivot, 'rotation_degrees:y', player_pivot.rotation_degrees.y + 90, 2.0)
	tween.finished.connect(_on_movement_end)

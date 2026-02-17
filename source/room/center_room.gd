class_name CenterRoom extends Node3D

@export var player_pivot: Node3D

var spots: Array[Node3D] = []

func _ready() -> void:
	EventBusSingleton.on_event.connect(_on_event)
	_load_spots()

func _load_spots() -> void:
	for section in get_children():
		var spot: Node3D = section.get_child(0).get_node("player_spot") 
		spots.push_back(spot)
	spots.pop_front()

func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _move_to_next_spot()

func _on_movement_end() -> void:
	EventBusSingleton.send_event(PlayerEndMovementEvent.new())

func _move_to_next_spot() -> void:
	var tween := create_tween()
	tween.tween_property(player_pivot, 'rotation_degrees:y', player_pivot.rotation_degrees.y + 90, 2.0)
	tween.finished.connect(_on_movement_end)

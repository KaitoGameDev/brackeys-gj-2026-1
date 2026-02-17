class_name Room extends Node3D

@export var sections: Array[PackedScene] = []

@onready var center: Node3D = $Center

var _halls: Array[Node3D] = []
var _current_hall := 0

func _ready() -> void:
	for hall in center.get_children():
		_halls.push_back(hall)
		
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _on_move_to_next_spot()
	if event is PlayerEndMovementEvent: return _on_playern_movement_end()
	
func _on_move_to_next_spot() -> void:
	if _current_hall == 3:
		EventBusSingleton.send_event(PlayerChangedFloorEvent.new())
	
func _on_playern_movement_end() -> void:
	if sections.size() == 0: return
	
	var old_section : Node3D = _halls[_current_hall].get_child(0)
	var section = sections.pop_front().instantiate()
	_halls[_current_hall].add_child(section)
	section.position = old_section.position
	old_section.queue_free.call_deferred()
	_current_hall += 1
	if _current_hall == 4:
		_current_hall = 0
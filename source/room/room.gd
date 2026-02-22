class_name Room extends Node3D

@export var sections: Array[PackedScene] = []
@export var environments: Array[Resource] = []

@onready var center: Node3D = $Center
@onready var world_environment: WorldEnvironment = $WorldEnvironment

var _halls: Array[Node3D] = []
var _current_hall := 0

func _ready() -> void:
	get_tree().root.use_occlusion_culling = true
	
	for hall in center.get_children():
		_halls.push_back(hall)
	EventBusSingleton.send_event(GameStartedEvent.new())
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _on_move_to_next_spot()
	if event is PlayerEndMovementEvent: return _on_playern_movement_end()
	
func _on_move_to_next_spot() -> void:
	if _current_hall == 3:
		var env = environments.pop_front()
		world_environment.environment = env
		EventBusSingleton.send_event(PlayerChangedFloorEvent.new())
	
func _on_playern_movement_end() -> void:
	if sections.size() == 0: return
	
	_current_hall += 1
	
	if _current_hall == 3:
		for i in 3:
			var old_section : Node3D = _halls[i].get_child(0)
			var section = sections.pop_front().instantiate()
			_halls[i].add_child.call_deferred(section)
			section.position = old_section.position
			old_section.queue_free.call_deferred()
	if _current_hall == 4:
		var old_section : Node3D = _halls[3].get_child(0)
		var section = sections.pop_front().instantiate()
		_halls[3].add_child.call_deferred(section)
		section.position = old_section.position
		old_section.queue_free.call_deferred()
		_current_hall = 0
class_name HUD extends Control

@onready var floor_counter_label : Label = $FloorCounter
@onready var floor_name_label : Label = $FloorName

var _moves := 0

func _ready() -> void:
	_render_floor_counter()
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent:
		_moves += 1
		_render_floor_counter()
	
func _render_floor_counter() -> void:
	var floor_count : int = _moves / 4
	floor_name_label.text = GlobalElements.floor_names[floor_count]
	floor_counter_label.text = 'Chamber - {0}'.format([_moves + 1])
class_name KeyItem extends Interactable

@export var next_puzzle_limit_time: float = 20.0
@export var open_door_number: int = 0

func _on_interact(): 
	var cursor_event := ChangeCursorEvent.new()
	cursor_event.cursor_type = ChangeCursorEvent.CursorType.TAKE
	cursor_event.label = ''
	EventBusSingleton.send_event(cursor_event)
	var move_event := MoveToNextSpotEvent.new()
	move_event.next_puzzle_limit_time = next_puzzle_limit_time
	move_event.open_door_number = open_door_number
	EventBusSingleton.send_event(move_event)
	queue_free.call_deferred()

class_name KeyItem extends Interactable

func _on_interact(): 
	var cursor_event := ChangeCursorEvent.new()
	cursor_event.cursor_type = ChangeCursorEvent.CursorType.TAKE
	cursor_event.label = ''
	EventBusSingleton.send_event(cursor_event)
	EventBusSingleton.send_event(MoveToNextSpotEvent.new())
	queue_free.call_deferred()

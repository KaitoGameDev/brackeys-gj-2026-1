class_name PlaySfxEvent

var sfx_name: String
var should_stop_after: float = -1

static func create(sfx: String, should_stop: float = -1) -> PlaySfxEvent:
	var event := PlaySfxEvent.new()
	event.sfx_name = sfx
	event.should_stop_after = should_stop
	return event
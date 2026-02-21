class_name CursorController extends Node

var cursors : Array[Resource] = [
	load('res://resources/cursors/normal.png'),
	load('res://resources/cursors/clickable.png'),
	load('res://resources/cursors/interactable.png'),
	load('res://resources/cursors/take.png')
]

var shapes : Array[int] = [
	Input.CURSOR_ARROW,
	Input.CURSOR_DRAG,
	Input.CURSOR_CROSS,
	Input.CURSOR_CAN_DROP
]

func _ready() -> void:
	EventBusSingleton.on_event.connect(_on_event)
	
	
func _on_event(event: Object) -> void:
	if event is ChangeCursorEvent:
		print(cursors[event.cursor_type])
		Input.set_custom_mouse_cursor(cursors[event.cursor_type], shapes[event.cursor_type])
		
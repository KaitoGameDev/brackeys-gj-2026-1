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

var spots : Array[Vector2] = [
	Vector2(5, 2),
	Vector2(5, 5),
	Vector2(5, 2),
	Vector2(5, 2),
]

func _ready() -> void:
	for i in 4:
		Input.set_custom_mouse_cursor(cursors[i], shapes[i], spots[i])
	EventBusSingleton.on_event.connect(_on_event)
	
	
func _on_event(event: Object) -> void:
	if event is ChangeCursorEvent:
		Input.set_default_cursor_shape(shapes[event.cursor_type])
		if event.cursor_type == ChangeCursorEvent.CursorType.TAKE:
			get_tree().create_timer(0.150).timeout.connect(
				func():
					Input.set_default_cursor_shape(shapes[0])
			) 
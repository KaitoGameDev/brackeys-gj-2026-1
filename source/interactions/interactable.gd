class_name Interactable
extends Node3D

@export var detector: Area3D
@export var hover_label: String

var _is_over_item := false

func _ready() -> void:
	detector.mouse_entered.connect(_on_mouse_entered)
	detector.mouse_exited.connect(_on_mouse_exited)
	
func _on_mouse_entered() -> void:
	_is_over_item = true
	var cursor_event := ChangeCursorEvent.new()
	cursor_event.cursor_type = ChangeCursorEvent.CursorType.INTERACTABLE
	
	if hover_label != null:
		cursor_event.label = hover_label
	
	EventBusSingleton.send_event(cursor_event)
	
func _on_mouse_exited() -> void:
	_is_over_item = false
	var cursor_event := ChangeCursorEvent.new()
	cursor_event.cursor_type = ChangeCursorEvent.CursorType.NORMAL
	cursor_event.label = ''
	EventBusSingleton.send_event(cursor_event)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and _is_over_item:
		_on_interact()
		
func _on_interact():
	print("Interactable clicked")

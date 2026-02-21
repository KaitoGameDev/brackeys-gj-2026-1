class_name EventBus extends Node

signal on_event(event: Object)

func _ready() -> void:
	get_tree().root.use_occlusion_culling = true

func send_event(event: Object) -> void:
	on_event.emit(event)

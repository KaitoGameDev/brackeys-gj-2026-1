class_name KeyItem extends Node3D

@onready var detector: Area3D = $Detector

var _is_over_item : bool = false

func _ready() -> void:
	detector.mouse_entered.connect(_on_mouse_entered)
	detector.mouse_exited.connect(_on_mouse_exited)
	
func _on_mouse_entered() -> void:
	_is_over_item = true
	
func _on_mouse_exited() -> void:
	_is_over_item = false
	
func _process(_delta: float) -> void:
	
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT) and _is_over_item:
		EventBusSingleton.send_event(MoveToNextSpotEvent.new())
		queue_free.call_deferred()

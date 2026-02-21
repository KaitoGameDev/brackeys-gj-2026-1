class_name HUD extends Control

@onready var floor_counter_label : Label = $FloorCounter
@onready var floor_name_label : Label = $FloorName
@onready var fade_out_panel: ColorRect = $FadeOutPanel
@onready var cursor_indicator_text := $CursorIndicatorText

var _moves := 0

func _ready() -> void:
	_render_floor_counter()
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is ChangeCursorEvent: return _on_change_cursor(event)
	if event is MoveToNextSpotEvent:
		_moves += 1
		_render_floor_counter()
		_check_floor_changing()
	
func _render_floor_counter() -> void:
	var floor_count : int = _moves / 4
	floor_name_label.text = GlobalElements.floor_names[floor_count]
	floor_counter_label.text = 'Chamber - {0}'.format([_moves + 1])
	
func _check_floor_changing() -> void:
	if _moves % 4 != 0: return
	var tween : Tween = create_tween()
	tween.tween_property(fade_out_panel, 'color:a', 1, 1.25).set_ease(Tween.EASE_IN)
	tween.tween_property(fade_out_panel, 'color:a', 0, 0.6).set_ease(Tween.EASE_OUT).set_delay(0.5)
	
	
func _on_change_cursor(event: ChangeCursorEvent) -> void:
	cursor_indicator_text.text = event.label
	
func _process(delta: float) -> void:
	cursor_indicator_text.global_position = get_global_mouse_position() + Vector2(40, -15)
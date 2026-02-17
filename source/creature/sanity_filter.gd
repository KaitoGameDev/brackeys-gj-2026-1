class_name SanityFilter extends ColorRect

@export var shader : ShaderMaterial
@export var time_seg: float = 20.0

var tween: Tween

func _ready() -> void:
	_reset_filter()
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _reset_filter()
	
func _reset_filter() -> void:
	if tween != null:
		tween.stop()
		tween = null
	tween = create_tween()	
	tween.tween_method(
		func(value):
			shader.set_shader_parameter('multiplier', value),
		0.0,
		0.5,
		time_seg
	)

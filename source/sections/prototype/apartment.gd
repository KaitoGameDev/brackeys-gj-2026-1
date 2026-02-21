class_name Apartment extends Node3D

@export var door_number: int = -1
@export var door_animator : AnimationPlayer


func _ready() -> void:
	EventBusSingleton.on_event.connect(_on_event)
	
func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _on_player_move(event)
	
	
func _on_player_move(event: MoveToNextSpotEvent) -> void:
	print(event.open_door_number)
	if event.open_door_number == door_number:
		door_animator.play('open')
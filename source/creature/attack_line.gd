class_name AttackLine extends Node3D
	
@export var velocity: float = -0.01
	
func _physics_process(delta: float) -> void:
	position = Vector3(position.x, position.y, position.z + (velocity * delta))
	
func _ready() -> void:
	get_tree().create_timer(5.0).timeout.connect(_hit_player)
	
	
func _hit_player() -> void:
	EventBusSingleton.send_event(PlayerHittedEvent.new())
	queue_free.call_deferred()

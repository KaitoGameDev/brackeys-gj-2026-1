class_name AttackLine extends Node3D
	
@export var velocity: float = -0.01

var eliminated := 0
var timer : SceneTreeTimer

func _ready() -> void:
	for child in get_children():
		(child as Attack).on_eliminated.connect(
			func():
				eliminated += 1
				if eliminated == 5:
					timer.timeout.disconnect(_hit_player)
					print("deleted line")
					queue_free.call_deferred()
		)
	
func _physics_process(delta: float) -> void:
	position = Vector3(position.x, position.y, position.z + (velocity * delta))
	
func activate() -> void:
	timer = get_tree().create_timer(5.0)
	timer.timeout.connect(_hit_player)
	
	
func _hit_player() -> void:
	EventBusSingleton.send_event(GameOverEvent.new())
	queue_free.call_deferred()

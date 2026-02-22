class_name ProjectionAttack extends Interactable

@export var velocity : float = 0.01

signal on_hit(was_fake: bool)

var _is_fake : bool = false

func _physics_process(delta: float) -> void:
	position = Vector3(position.x, position.y, position.z + (velocity * delta))

func mark_as_fake() -> void:
	_is_fake = true
	get_node("./Sprite").modulate.a = 0.25
	
func _on_interact():
	if !_is_fake:
		EventBusSingleton.send_event(PlaySfxEvent.create('hit_monster'))
	on_hit.emit(_is_fake)
	
	

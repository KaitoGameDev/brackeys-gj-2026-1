class_name Attack extends Interactable

@export var sprites: Array[Texture2D] = []
@export var velocity : float = 0.01

@onready var sprite: Sprite3D = $Sprite3D

signal on_eliminated

func _on_interact() -> void:
	super._on_mouse_exited()
	EventBusSingleton.send_event(PlaySfxEvent.create('hit_monster'))
	on_eliminated.emit()
	queue_free.call_deferred()
	
func _physics_process(delta: float) -> void:
	position = Vector3(position.x, position.y, position.z + (velocity * delta))
	
func _ready() -> void:
	super._ready()
	EventBusSingleton.send_event(PlaySfxEvent.create('spawn_attack'))
	sprite.texture = sprites.pick_random()
	if velocity != 0.0:
		position.y = randf_range(0.5, 1)
		position.x = randf_range(-1.0, 1.0)

func activate() -> void:
	get_tree().create_timer(6.0).timeout.connect(_hit_player)
	
	
func _hit_player() -> void:
	EventBusSingleton.send_event(GameOverEvent.new())
	queue_free.call_deferred()

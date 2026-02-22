extends Node3D

var _moves : int = 1
var _eliminated_attacks : int = 0

@export var key_item: KeyItem
@export var attacks: PackedScene
@export var creature: Creature

var should_stop := false
var y_positions : Array[float] = [0.2, 0.5, 0.8]

var emitted_attacks: Array[AttackLine] = []

func _ready() -> void:
	EventBusSingleton.on_event.connect(_on_event)
	
	
func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _handle_player_movement()
	

func _handle_player_movement() -> void:
	_moves += 1
	if _moves == 4:
		get_tree().create_timer(2.0).timeout.connect(_start_puzzle)
		
func _start_puzzle() -> void:
	if should_stop:
		return
		
	await get_tree().create_timer(randf_range(0.8, 1.5)).timeout
	
	_spawn_attack()
	_start_puzzle()
	
func _validate_attacks() -> void:
	_eliminated_attacks += 1
	if _eliminated_attacks == 28:
		creature.disappear()
		key_item.visible = true
		should_stop = true
		for attack in emitted_attacks:
			if attack != null:
				attack.queue_free.call_deferred()
		queue_free.call_deferred()
	
func _spawn_attack() -> void:
	var attack : AttackLine = attacks.instantiate()
	attack.velocity = -0.30
	attack.position = position
	attack.position.y = y_positions.pick_random()
	for sub_attack in attack.get_children():
		(sub_attack as Attack).on_eliminated.connect(_validate_attacks)
	add_sibling(attack)
	emitted_attacks.push_back(attack)
	attack.activate()

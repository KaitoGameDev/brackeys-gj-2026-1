class_name Puzzle_3 extends Node3D

var _moves : int = 1
var _eliminated_attacks : int = 0
var _cancelled_hit := false
var timer: SceneTreeTimer
var message_timer: SceneTreeTimer

@export var key_item: KeyItem
@export var attack: PackedScene

@onready var message_container: Control = $Control/Background
@onready var messages_label: RichTextLabel = $Control/Background/Messages

var should_stop := false
var y_positions : Array[float] = [0.2, 0.5, 0.8]
var current_attacks : Array[ProjectionAttack] = []
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
		
	_spawn_attack()	
	
func _validate_attacks() -> void:
	_eliminated_attacks += 1
	print(_eliminated_attacks)
	if _eliminated_attacks == 10:
		should_stop = true
		key_item.visible = true
		queue_free.call_deferred()
	else:
		await get_tree().create_timer(1.0).timeout
		_start_puzzle()
	
func _on_hit_projection(was_fake: bool) -> void:
	_cancelled_hit = true
	timer.timeout.disconnect(_show_fail_message)
	for projection in current_attacks:
		projection.queue_free.call_deferred()
		
	if !was_fake:
		_validate_attacks()
		_show_hitted_message()
	else:
		_show_fake_message()
		get_tree().create_timer(2.0).timeout.connect(_start_puzzle)

func _show_message(text: String) -> void:
	if message_timer:
		message_timer.timeout.disconnect(_disappear_message)
	message_container.visible = true
	messages_label.text = text
	message_timer = get_tree().create_timer(2.0)
	message_timer.timeout.connect(_disappear_message)
		
func _show_fake_message() -> void:
	_show_message('You Fool!, that was fake\n[shake]HAHAHAHA[/shake]')
	
	
func _show_hitted_message() -> void:
	_show_message('[shake]AHHH!! I will get you![/shake]')
	
func _show_fail_message() -> void:
	_cancelled_hit = true
	_start_puzzle()
	_show_message('[shake]JE je JE! part of you is mine![/shake]')
	
func _disappear_message() -> void:
	message_container.visible = false
	
func _spawn_attack() -> void:
	_cancelled_hit = false
	var attack_1 : ProjectionAttack = attack.instantiate()
	var attack_2 : ProjectionAttack = attack.instantiate()
	current_attacks = [attack_1, attack_2]
	attack_1.position = Vector3(0.5, 0.7, 0.8)
	attack_2.position = Vector3(-0.5, 0.7, 0.8)
	
	attack_1.velocity = -0.85
	attack_2.velocity = -0.85
	
	attack_1.on_hit.connect(_on_hit_projection)
	attack_2.on_hit.connect(_on_hit_projection)
	
	add_sibling.call_deferred(attack_1)
	add_sibling.call_deferred(attack_2)
	
	var fake_one = [attack_1, attack_2].pick_random()
	fake_one.mark_as_fake()
	
	timer = get_tree().create_timer(2.5)
	timer.timeout.connect(_show_fail_message)

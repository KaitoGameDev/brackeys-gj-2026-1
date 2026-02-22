extends Control

var _moves : int = 1
var message_timer: SceneTreeTimer

@export var key_item: KeyItem
@export var creature: Creature

@onready var message_container: Control = $Background
@onready var messages_label: RichTextLabel = $Background/Messages

func _ready() -> void:
	EventBusSingleton.on_event.connect(_on_event)
	
	
func _on_event(event: Object) -> void:
	if event is MoveToNextSpotEvent: return _handle_player_movement()
	

func _handle_player_movement() -> void:
	_moves += 1
	if _moves == 4:
		get_tree().create_timer(2.0).timeout.connect(_start_puzzle)
		
func _start_puzzle() -> void:
	EventBusSingleton.send_event(PlaySfxEvent.create('monster_talk'))
	_show_message('[shake]You may have won this time...[/shake]')
	await get_tree().create_timer(2.0).timeout
	EventBusSingleton.send_event(PlaySfxEvent.create('monster_talk'))
	_show_message('But I am a part of you\n[shake]whether you like or not![/shake]')
	await get_tree().create_timer(4.0).timeout
	EventBusSingleton.send_event(PlaySfxEvent.create('monster_talk'))
	_show_message('I\'ll [shake]always[/shake] be chasing you down.')
	await get_tree().create_timer(3.0).timeout
	creature.disappear()
	key_item.visible = true
	_disappear_message()

func _show_message(text: String) -> void:
	message_container.visible = true
	messages_label.text = text

		
func _disappear_message() -> void:
	message_container.visible = false

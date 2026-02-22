class_name GameOverScreen extends Control

@onready var try_again_btn: Button = $TryAgainBtn
@onready var main_menu_btn: Button = $MainMenuBtn

func _ready() -> void:
	EventBusSingleton.on_event.connect(_on_event)
	try_again_btn.pressed.connect(_on_try_again_pressed)
	main_menu_btn.pressed.connect(_on_back_to_menu_pressed)
	
func _on_event(event: Object) -> void:
	if event is GameOverEvent:
		visible = true
		
func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_back_to_menu_pressed() -> void:
	get_tree().change_scene_to_file('res://source/main/main_menu.tscn')
		

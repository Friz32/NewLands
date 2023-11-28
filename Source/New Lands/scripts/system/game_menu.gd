extends CanvasLayer

@onready var create_server_button: BaseButton = %CreateServer

func _ready():
	visible = false

func _unhandled_input(event):
	if InputMap.has_action("game_menu") && event.is_action_pressed("game_menu"):
#		var v = visible
#		get_tree().call_group("screen", "set_visible", false)
#		visible = !v
		
		visible = !visible
		get_tree().paused = !get_tree().paused
		get_tree().root.set_input_as_handled()

func on_return_to_game_pressed():
	visible = false
	get_tree().paused = false

func on_quit_pressed():
	get_tree().quit()

func on_main_menu_pressed():
	get_tree().paused = false
	SaveSystem.update_player_data()
	get_tree().change_scene_to_packed(Res["scn_main_menu"])

func on_create_server_pressed() -> void:
	Networking.create_server()
	create_server_button.disabled = true

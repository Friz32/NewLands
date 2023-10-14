extends PopupPanel

signal ok(count: int)

@onready var spin_box: SpinBox = %SpinBox
@onready var slider: HSlider = %Slider

func _input(event: InputEvent) -> void:
	if event.is_action("ui_accept"):
		on_ok_pressed()

func on_ok_pressed() -> void:
	ok.emit(spin_box.value)
	queue_free()

func on_all_pressed() -> void:
	spin_box.value = spin_box.max_value

func on_slider_value_changed(value: float) -> void:
	spin_box.value = slider.ratio * spin_box.max_value

extends Control

enum Channel {
	R,
	G,
	B,
	A,
}
@onready var option_button: OptionButton = $PanelContainer/HBoxContainer/OptionButton

var selected_channel: Channel:
	get:
		return option_button.selected as Channel

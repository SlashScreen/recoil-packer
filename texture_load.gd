extends Control


@onready var file_dialog: FileDialog = $FileDialog
@onready var texture_button: TextureButton = $PanelContainer/TextureButton
var img: Image = Image.new()
var img_tex: ImageTexture = ImageTexture.new()


func _on_texture_button_pressed() -> void:
	print("Pressed...")
	file_dialog.popup_centered()


func _on_file_dialog_file_selected(path: String) -> void:
	print("Loading ", path)
	file_dialog.hide()
	img = Image.load_from_file(path)
	img_tex.set_image(img)
	texture_button.texture_normal = img_tex
